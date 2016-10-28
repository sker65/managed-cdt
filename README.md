# managed-cdt
Docker image to build arm projects in jenkins / bitbucket pipelines headless with eclipse cdt

## Use eclipse cdt in headless mode

To build a cdt managed project from the cmdline one can use:

```
eclipse/eclipse --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild
```

When in a ci environment like jenkins or bitbucket pipelines your code base is always cloned into a fresh and clean working
directory so you need to "import" your project first into a eclipse workspace. So the complete call would be

```
eclipse/eclipse --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild \
-data /workspace -import /workdir/<project> -cleanBuild <project>/<build-config>
```

<dl>
  <dt>-data</dt>
  <dd>defines the directory for the eclipse workspace. Normally this is only temporary you could delete it after the build</dd>
  <dt>-import</dt>
  <dd>points to the cloned project directory.</dd>
  <dt>-cleanBuild</dt>
  <dd>starts the build with one of the build configurations (e.g. Debug or Release).</dd>
</dl>

## Example for bitbucket pipeline definition

```yml
image:
    name: sker65/managed_cdt_build

pipelines:
  default:
    - step:
        script:
            - mkdir /opt/atlassian/pipelines/agent/workspace
            - export PATH=$PATH:/work/gcc-arm-none-eabi-5_2-2015q4/bin
            - /work/eclipse/eclipse --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /opt/atlassian/pipelines/agent/workspace -import /opt/atlassian/pipelines/agent/build -cleanBuild <project>/Debug
```
