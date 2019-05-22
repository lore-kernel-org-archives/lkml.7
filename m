Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA030C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDDE20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558541061;
	bh=KL0xSRRx52pYQmOhsgghRmXFU/B5bb60ts9K/5Isplo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=q06FZJwJyr6gtj77nLTIKekfEe3D7xr4xmeDQV68RtcIg1H2mw79w4jvKVUlWzN28
	 TP4bioCTx6mDVsYl/Led3FMH6UZqm3C1k0sDIxLHtOpcQluI/A8rWwlS8MxBQMNs8D
	 4k8IO1I93AbbTfCcmKGOIulm6R2tUaV1BB4K7O0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfEVQEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:04:20 -0400
Received: from casper.infradead.org ([85.118.1.10]:54394 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QRMlBTzg/wPc6H30GKyU4T0Dz4IABEqiLo1Mo/8ui3A=; b=I1sjJdFshzjkinDQ/kTE2Doovw
        2g2XuMiGvdkQD/R++KBuVA2RXOINTa8QvuD9JW4tV4eCAk2on8Ow78/4wcfBKPBYJP+oenBPIw5Zm
        tWVPEkEWHMYDJLBrSR1E6OAsPjVNDnOG0WH+UDmgnqBqaSxuB9yrOnz0p7WiRSW1bwqQVqV3qvUcQ
        jQJ7C2YraRVyH5r2ZrdLi62xVOsAR7Gu4Z/4giZDRKa1Elrx0IabUixnsq95DCdcafysFEicWZMz5
        GpaVjxK9yOIXIKHTuY0wEKeBvegAlx8rYSMs0OCje7dFr2ZX8lXYH4ytGAdJWHULjoBnWm6vRUqcL
        Pw77RCtA==;
Received: from [179.182.168.126] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTTiv-0002U0-Pe; Wed, 22 May 2019 16:04:14 +0000
Date:   Wed, 22 May 2019 13:04:08 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] docs: Deal with some Sphinx deprecation
 warnings
Message-ID: <20190522130408.5d8258de@coco.lan>
In-Reply-To: <20190522094559.5ed8021e@lwn.net>
References: <20190521211714.1395-1-corbet@lwn.net>
        <87d0kb7xf6.fsf@intel.com>
        <20190522071909.050bb227@coco.lan>
        <39b12927-9bf9-a304-4108-8f471a204f89@darmarit.de>
        <20190522094559.5ed8021e@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 22 May 2019 09:45:59 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 22 May 2019 15:25:36 +0200
> Markus Heiser <markus.heiser@darmarit.de> wrote:
> 
> > Lets use 1.7 :
> > 
> > - no need for Use_SSI wrapper
> > - new log should work with 1.7 [1] --> no need for kernellog.py and
> >    additional imports, instead include on top of python modules ::
> > 
> >      from sphinx.util import logging
> >      logger = logging.getLogger('kerneldoc')  
> 
> I think we're going to have to drag things forward at some point in the
> not-too-distant future, but I think I'd rather not do that quite yet.  The
> cost of supporting older sphinx for a few releases while we warn people is
> not all that high.  So I think we should:
> 
>  - Put in (a future version of) my hacks for now, plus whatever else might
>    be needed to make 2.0 work right.
> 
>  - Fix the fallout with regard to out-of-toctree .rst files so that we can
>    actually build again with current sphinx.
> 
>  - Update Documentation/sphinx/requirements.txt to ask for something a wee
>    bit more recent than 1.4.9.

You should remember to also update conf.py (with currently points to 1.3):

	# If your documentation needs a minimal Sphinx version, state it here.
	needs_sphinx = '1.3'

Also, if you touch there, you should also touch:

	./scripts/sphinx-pre-install

The change there won't be as trivial as just changing this line:

	$virtenv_dir = "sphinx_1.4";

as the script should now run sphinx-build --version, in order to check
if the version is lower than the new minimal version. It probably makes
sense to make it grep the version from needs_sphinx at conf.py.

>  - Add a warning when building with an older version that (say) 1.7 will
>    be required as of (say) 5.5.

It probably makes sense to add such check at the pre-install script,
and add a:

	SPHINXOPTS="-jauto"

somewhere if version is 1.7 or upper.

> 
> Does this make sense?

It makes sense to me.

Thanks,
Mauro
