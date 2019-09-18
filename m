Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C59C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF050214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568798976;
	bh=kEn+18SY70aKjBGPk51sBtFUKs+qo2Iz2Lz91jz4Uo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sb1+idu5Fwncbeze8aeTsIzDoIgsHDatKU2pEFEVIgy5naxn+fwPAYQAs+NukW15h
	 lxoH7VWaliDrhWdEKj7CWzBUNCXi6uoqXKSBMq0qMA1GlKi89m8xOPjkH1cMrtjSlC
	 p/n5/EuXRK3QP1e+FFFw90zdf7kvzHfvpLPddD24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfIRJ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:29:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfIRJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LiGR9XEMuBTajmH0xruBSTvxCoSQ4vfmQBJv25M7LJI=; b=DVR8G598sToMaI10QegOpsYQ7
        fyjy1Fz1Hjo9Z2qXx4j0WrMIev2OM0KpolYP8JjrqGQ8YKQQ4PtRtTtNyOMUCrQt97kTpE9TT0znO
        FvZLXsJ5SRhDj80w/h0d9sHuYoQaeb/WG9ID4JWeRsSXoN53oKG+Gp0PRzrv0hLaRfBl5gcoa3yYE
        GmxN0qfMxZ0RDvM/JJ4cHsqe08t/DfkyoqOlbHs9ETf2foQJbCaOHZmne6OGdK+nyoRU4MvheH0Tx
        l/YOZ9dw9zNv5JP8A058hHdZzH6U40+UUJdzrW/pfo0XYZfJ1/L3tBDi2aUBvJ/fhSxwdFO+GAjb5
        S417fKJOw==;
Received: from 177.96.192.152.dynamic.adsl.gvt.net.br ([177.96.192.152] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAWH8-0003yc-Kw; Wed, 18 Sep 2019 09:29:27 +0000
Date:   Wed, 18 Sep 2019 06:29:21 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, rppt@linux.ibm.com, rfontana@redhat.com,
        kstewart@linuxfoundation.org, bhelgaas@google.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/sphinx-pre-install: add how to exit virtualenv
 usage message
Message-ID: <20190918062921.73a45f2d@coco.lan>
In-Reply-To: <20190917224805.2762-1-skhan@linuxfoundation.org>
References: <20190917224805.2762-1-skhan@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Em Tue, 17 Sep 2019 16:48:05 -0600
Shuah Khan <skhan@linuxfoundation.org> escreveu:

> Add usage message on how to exit the virtualenv after documentation
> work is done.

Good idea.

> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  scripts/sphinx-pre-install | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 3b638c0e1a4f..932547791e3c 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -645,6 +645,12 @@ sub check_distros()
>  # Common dependencies
>  #
>  
> +sub deactivate_help()
> +{
> +	printf "\tWhen work is done exit the virtualenv:\n";
> +	printf "\tdeactivate\n";

I would change the message to something like:

	If you want to exit the virtualenv, you can use:

		deactivate

Btw, at least here, I recently noticed a conflict between the
virtenv and scripts/spdxcheck.py. Running deactivate solves it.

Regards,
Mauro



> +}
> +
>  sub check_needs()
>  {
>  	# Check for needed programs/tools
> @@ -686,6 +692,7 @@ sub check_needs()
>  		if ($need_sphinx && scalar @activates > 0 && $activates[0] ge $min_activate) {
>  			printf "\nNeed to activate a compatible Sphinx version on virtualenv with:\n";
>  			printf "\t. $activates[0]\n";
> +			deactivate_help();
>  			exit (1);
>  		} else {
>  			my $rec_activate = "$virtenv_dir/bin/activate";
> @@ -697,6 +704,7 @@ sub check_needs()
>  			printf "\t$virtualenv $virtenv_dir\n";
>  			printf "\t. $rec_activate\n";
>  			printf "\tpip install -r $requirement_file\n";
> +			deactivate_help();
>  
>  			$need++ if (!$rec_sphinx_upgrade);
>  		}



Thanks,
Mauro
