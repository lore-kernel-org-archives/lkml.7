Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5778C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6416220673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561127243;
	bh=bqy4/+kxSm+jgHzKE6b2i4wvuvM2u6ZDdEvo68j/pAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KuDygv4xcWweJHR+FyrjvCLe9mW94iBdp4GcBjwOoqQFTP56GEdq2r/eaEKVToYVU
	 zS7S0uJn8QQmx6/HvJWOEb/RWer8F1/3cG8pRxhFMEgvgT6+4DhSrXp88vNQvN0Eah
	 uhb+yGkoGrHLfUYfNpRv8F7ZONB8rgGWwr2P/5BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfFUO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:27:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUO1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s2ve/bhc+6sC3wPB1Be4ZkJJdWjcnNZ6Bftms22+fZY=; b=ktq6g/rj1d89F338oTtsGH4uX
        kNPzALZxiOICTUE5sZOZniRhk4I2gyP8KFhS1EUk2pRfgCSiNs3fkgmlcoPgP1nLIssbGfjFhCd/8
        GVjflqKsRjCCzH9Dwf1Jy05FMDqL6l4/zyBhwjCEaWLiIKN///6ttzWGuOlw8yfzmdBSax/jNVx75
        KRyBJu7fbwU3DkD6Gmtcp4KhgwPegRpbRkpmXSX9lcARXp8bWRbLJtwfJTFWyl1G6otLtjY3PCnih
        Hyj10wPyRvJfvjYTfwF9fMzVbO4rMp8LLXp8YQsHwzDxD2vfAvqtBrGheYz8D2l1hBWau+3kbXs5/
        XiCou31Ew==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heKVc-0006be-8M; Fri, 21 Jun 2019 14:27:20 +0000
Date:   Fri, 21 Jun 2019 11:27:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
Message-ID: <20190621112700.6922d80d@coco.lan>
In-Reply-To: <20190619133739.44f92409@coco.lan>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
        <87o930uvur.fsf@intel.com>
        <20190614140603.GB7234@kroah.com>
        <20190614122755.1c7b4898@coco.lan>
        <874l4ov16m.fsf@intel.com>
        <20190617105154.3874fd89@coco.lan>
        <87h88nth3v.fsf@intel.com>
        <20190619133739.44f92409@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 19 Jun 2019 13:37:39 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Tue, 18 Jun 2019 11:47:32 +0300
> Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> 
> > On Mon, 17 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:  
> > > Yeah, I guess it should be possible to do that. How a python script
> > > can identify if it was called by Sphinx, or if it was called directly?    
> > 
> > if __name__ == '__main__':
> > 	# run on the command-line, not imported  
> 
> Ok, when I have some spare time, I may try to convert one script
> to python and see how it behaves. 

Did a quick test here... 

Probably I'm doing something wrong (as I'm a rookie with Python), but,
in order to be able to use the same script as command line and as an Sphinx
extension, everything that it is currently there should be "escaped"
by an:

	if __name__ != '__main__':

As event the class definition:

    class KernelCmd(Directive):

depends on:

	from docutils.parsers.rst import directives, Directive

With is only required when one needs to parse ReST - e. g. only
when the script runs as a Sphinx extension.

If this is right, as we want a script that can run by command line
to parse and search inside ABI files, at the end of the day, it will
be a lot easier to maintain if the parser script is different from the
Sphinx extension. 

If so, as the Sphinx extension script will need to call a parsing script
anyway, it doesn't matter the language of the script with will be
doing the ABI file parsing.

See the enclosing file. I didn't add anything from the ABI parsing
script yet. It was just changed in order to not generate an error
when trying to run it from command line.


Thanks,
Mauro
#!/usr/bin/env python3
# coding=utf-8
# SPDX-License-Identifier: GPL-2.0
#
u"""
    kernel-abi
    ~~~~~~~~~~

    Implementation of the ``kernel-abi`` reST-directive.

    :copyright:  Copyright (C) 2016  Markus Heiser
    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.

    The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
    scripts/get_abi.pl script to parse the Kernel ABI files.

    Overview of directive's argument and options.

    .. code-block:: rst

        .. kernel-abi:: <ABI directory location>
            :debug:

    The argument ``<ABI directory location>`` is required. It contains the
    location of the ABI files to be parsed.

    ``debug``
      Inserts a code-block with the *raw* reST. Sometimes it is helpful to see
      what reST is generated.

"""

import codecs
import os
import subprocess
import sys

from os import path

if __name__ != '__main__':
    from docutils import nodes, statemachine
    from docutils.statemachine import ViewList
    from docutils.parsers.rst import directives, Directive
    from docutils.utils.error_reporting import ErrorString

    #
    # AutodocReporter is only good up to Sphinx 1.7
    #
    import sphinx

    Use_SSI = sphinx.__version__[:3] >= '1.7'
    if Use_SSI:
        from sphinx.util.docutils import switch_source_input
    else:
        from sphinx.ext.autodoc import AutodocReporter

__version__  = '1.0'

if __name__ != '__main__':
    def setup(app):

        app.add_directive("kernel-abi", KernelCmd)
        return dict(
            version = __version__
            , parallel_read_safe = True
            , parallel_write_safe = True
        )

    class KernelCmd(Directive):

        u"""KernelABI (``kernel-abi``) directive"""

        required_arguments = 1
        optional_arguments = 2
        has_content = False
        final_argument_whitespace = True

        option_spec = {
            "debug"     : directives.flag,
            "rst"       : directives.unchanged
        }

        def warn(self, message, **replace):
            replace["fname"]   = self.state.document.current_source
            replace["line_no"] = replace.get("line_no", self.lineno)
            message = ("%(fname)s:%(line_no)s: [kernel-abi WARN] : " + message) % replace
            self.state.document.settings.env.app.warn(message, prefix="")

        def run(self):

            doc = self.state.document
            if not doc.settings.file_insertion_enabled:
                raise self.warning("docutils: file insertion disabled")

            env = doc.settings.env
            cwd = path.dirname(doc.current_source)
            fname = self.arguments[0]

            cmd = "get_abi.pl rest --dir "
            cmd += fname

            if 'rst' in self.options:
                cmd += " --rst-source"

            srctree = path.abspath(os.environ["srctree"])

            # extend PATH with $(srctree)/scripts
            path_env = os.pathsep.join([
                srctree + os.sep + "scripts",
                os.environ["PATH"]
            ])
            shell_env = os.environ.copy()
            shell_env["PATH"]    = path_env
            shell_env["srctree"] = srctree

            lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
            nodeList = self.nestedParse(lines, self.arguments[0])
            return nodeList

        def runCmd(self, cmd, **kwargs):
            u"""Run command ``cmd`` and return it's stdout as unicode."""

            try:
                proc = subprocess.Popen(
                    cmd
                    , stdout = subprocess.PIPE
                    , stderr = subprocess.PIPE
                    , **kwargs
                )
                out, err = proc.communicate()

                out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')

                if proc.returncode != 0:
                    raise self.severe(
                        u"command '%s' failed with return code %d"
                        % (cmd, proc.returncode)
                    )
            except OSError as exc:
                raise self.severe(u"problems with '%s' directive: %s."
                                % (self.name, ErrorString(exc)))
            return out

        def nestedParse(self, lines, fname):
            content = ViewList()
            node    = nodes.section()

            if "debug" in self.options:
                code_block = "\n\n.. code-block:: rst\n    :linenos:\n"
                for l in lines.split("\n"):
                    code_block += "\n    " + l
                lines = code_block + "\n\n"

            for c, l in enumerate(lines.split("\n")):
                content.append(l, fname, c)

            buf  = self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter

            if Use_SSI:
                with switch_source_input(self.state, content):
                    self.state.nested_parse(content, 0, node, match_titles=1)
            else:
                self.state.memo.title_styles  = []
                self.state.memo.section_level = 0
                self.state.memo.reporter      = AutodocReporter(content, self.state.memo.reporter)
                try:
                    self.state.nested_parse(content, 0, node, match_titles=1)
                finally:
                    self.state.memo.title_styles, self.state.memo.section_level, self.state.memo.reporter = buf

            return node.children
