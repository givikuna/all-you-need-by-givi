import * as fs from "fs";
import * as prettier from "prettier";

async function prettify(): Promise<void> {
    fs.writeFileSync(
        "./Index.ts",
        await prettier.format(String(fs.readFileSync("./Index.ts", "utf-8")), {
            parser: "typescript",
            ...require("./.prettierrc.json"),
        }),
    );
}

prettify();
