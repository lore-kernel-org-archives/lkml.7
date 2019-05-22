Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B47C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D743120879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558543216;
	bh=IDFUd+TeybTylPWdEyLgQ36YwPWu/M6VLUZcD15vg+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T51J9yH6q5jLhqvpEkIYigzpXK5G+B09hSP04hG8zPj3g3XBfIXlnJe5IKCgqbSR6
	 ux6ZHzQSZV7E9VxeOw9YafIJ413pSU/8tPiLyBKEnUDQ9LhsrxJ5FTqe+7/Db4jCgJ
	 FpiXPcfqkAl+Altt9pDmAudB4u45kko3gE+dJs1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfEVQkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:40:14 -0400
Received: from casper.infradead.org ([85.118.1.10]:57906 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbfEVQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/DgP3y4Vc92ynbSaiYOp1/FU9ajFdFjIAj44W+6Bo0=; b=F5Snobjd0WCvUkrngZzq0c1ClG
        hUcbzU6MedzB8kTG1UCBEiEZqHpA1LWwthSqh5OSJpt8eZoLGRmDb9p8OW5ixQl6MK5g1qKs9CmgC
        9NH1scRSkihptXriPKvmMV26AwiuuSWz7ZtiAhe8pOVNDnD7TH8iL1Cow54A3VpO0bxkEcQrbcPL0
        Pxaq/NaTWMfaxfLrOPR9v/nTRcVSwDCmvkqPztvDt/EyKIXqcDlruf9uP9Rzc4XlluKWJXJi6X+KW
        pIAGMAV3gDhqD8CU7P82rq6Z1XQ67ZqnZ3j2qt9mVanVV6SqXUMHzl+nx52KxAM2t/7PzN6ANU9sF
        UpPAzvzQ==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTUHh-0003tM-SN; Wed, 22 May 2019 16:40:10 +0000
Date:   Wed, 22 May 2019 13:40:05 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation
 warnings
Message-ID: <20190522134005.74d63bc3@coco.lan>
In-Reply-To: <20190522130408.5d8258de@coco.lan>
References: <20190521211714.1395-1-corbet@lwn.net>
        <87d0kb7xf6.fsf@intel.com>
        <20190522071909.050bb227@coco.lan>
        <39b12927-9bf9-a304-4108-8f471a204f89@darmarit.de>
        <20190522094559.5ed8021e@lwn.net>
        <20190522130408.5d8258de@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 22 May 2019 13:04:08 -0300
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Em Wed, 22 May 2019 09:45:59 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > On Wed, 22 May 2019 15:25:36 +0200
> > Markus Heiser <markus.heiser@darmarit.de> wrote:
> >   
> > > Lets use 1.7 :
> > > 
> > > - no need for Use_SSI wrapper
> > > - new log should work with 1.7 [1] --> no need for kernellog.py and
> > >    additional imports, instead include on top of python modules ::
> > > 
> > >      from sphinx.util import logging
> > >      logger = logging.getLogger('kerneldoc')    
> > 
> > I think we're going to have to drag things forward at some point in the
> > not-too-distant future, but I think I'd rather not do that quite yet.  The
> > cost of supporting older sphinx for a few releases while we warn people is
> > not all that high.  So I think we should:
> > 
> >  - Put in (a future version of) my hacks for now, plus whatever else might
> >    be needed to make 2.0 work right.
> > 
> >  - Fix the fallout with regard to out-of-toctree .rst files so that we can
> >    actually build again with current sphinx.
> > 
> >  - Update Documentation/sphinx/requirements.txt to ask for something a wee
> >    bit more recent than 1.4.9.  
> 
> You should remember to also update conf.py (with currently points to 1.3):
> 
> 	# If your documentation needs a minimal Sphinx version, state it here.
> 	needs_sphinx = '1.3'
> 
> Also, if you touch there, you should also touch:
> 
> 	./scripts/sphinx-pre-install
> 
> The change there won't be as trivial as just changing this line:
> 
> 	$virtenv_dir = "sphinx_1.4";
> 
> as the script should now run sphinx-build --version, in order to check
> if the version is lower than the new minimal version. It probably makes
> sense to make it grep the version from needs_sphinx at conf.py.
> 
> >  - Add a warning when building with an older version that (say) 1.7 will
> >    be required as of (say) 5.5.  
> 
> It probably makes sense to add such check at the pre-install script,
> and add a:
> 
> 	SPHINXOPTS="-jauto"
> 
> somewhere if version is 1.7 or upper.
> 

I'm meaning something like the enclosed patch.

(PS.: I'm still working at the patch)



Thanks,
Mauro

[RFC PATCH] scripts/sphinx-pre-install: make it handle Sphinx versions

As we want to switch to a newer Sphinx version in the future,
add some version detected logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f6a5c0bae31e..8835aede4c61 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -13,7 +13,7 @@ use strict;
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-my $virtenv_dir = "sphinx_1.4";
+my $conf = "Documentation/conf.py";
 my $requirement_file = "Documentation/sphinx/requirements.txt";
 
 #
@@ -27,6 +27,10 @@ my $optional = 0;
 my $need_symlink = 0;
 my $need_sphinx = 0;
 my $install = "";
+my $min_version;
+my $rec_version;
+my $cur_version;
+my $virtenv_dir = "sphinx_";
 
 #
 # Command line arguments
@@ -76,6 +80,52 @@ my %texlive = (
 # Subroutines that checks if a feature exists
 #
 
+sub handle_sphinx_version()
+{
+	open IN, $conf;
+	while (<IN>) {
+		if (m/^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]/) {
+			$min_version=$1;
+			last;
+		}
+	}
+	close IN;
+
+	die "Can't get needs_sphinx version from $conf" if (!$min_version);
+
+	open IN, $requirement_file;
+	while (<IN>) {
+		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
+			$rec_version=$1;
+			last;
+		}
+	}
+	close IN;
+
+	open IN, "sphinx-build --version 2>&1 |";
+	while (<IN>) {
+		if (m/^\s*sphinx-build\s+([\d\.]+)$/) {
+			$cur_version=$1;
+			last;
+		}
+	}
+	close IN;
+
+	$virtenv_dir .= $rec_version;
+
+	# Sphinx is not installed
+	return if (!$cur_version);
+
+	if ($cur_version lt $min_version) {
+		print "Sphinx version older than $min_version! We recommend at least $rec_version";
+		exit -1;
+	}
+
+	if ($cur_version lt $rec_version) {
+		print "Warning: we recommend at least Sphinx version $rec_version";
+	}
+}
+
 sub check_missing(%)
 {
 	my %map = %{$_[0]};
@@ -587,6 +637,8 @@ while (@ARGV) {
 	}
 }
 
+handle_sphinx_version();
+
 #
 # Determine the system type. There's no standard unique way that would
 # work with all distros with a minimal package install. So, several


