package;

import haxe.ds.StringMap;
import Lambda;
import sys.io.Process;

import tink.cli.*;
import tink.Cli;

class Application {
    static var version: StringMap<Int> = [
        'major' => 0,
        'minor' => 1,
        'patch' => 2
    ];
    
    public function new() {}
    
    @:defaultCommand
    public function run(rest: Rest<String>) {
        var message = [
            'Gix',
            [
                version.get('major'),
                version.get('minor'),
                version.get('patch')
            ].join('.'),
            '© Ray Perry 2019 - present.'
        ].join(' ');
        Sys.println(message);
        if (rest.length > 0) {
            Sys.println('Arguments provided.');
            return;
        }

        var status: Process = new Process('git status');
        Sys.println(status.stdout.readAll());
        status.close();
    }

    static function main() {
        Cli.process(Sys.args(), new Application()).handle(Cli.exit);
    }
}
