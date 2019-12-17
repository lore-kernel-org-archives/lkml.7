Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF43EC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C3821835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghEfgYlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLQQEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:04:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8pz2TWNx/nYHSnb/3v/c/XUDOnHlIu5NwAdxkQteJrQ=; b=ghEfgYlhDr7qiiNNbCkaK1FGg
        Bh+3P6BA8Uvi66XxHM6UyhadULk5T9fu+dMgimux+e/KPIbYTv/vvIB4M4Rgs3kV2uBaRGe9JL7DX
        T/mmRCI3DGEPyQBdClpL6FLBtHimCtpDAneO+AzQaJBF8PcS1tMxffLIuxFzjbBysOjZD2P6gjImW
        1dws1VEHxdiyXAzLPuBkfd0mS1CvqNaun0mUR6gA+4AXjF0VyRdXTXIkQIWbvssSlxhv/MJ66sY2C
        ouYIv5QVzw4Yi8wihvqpZYhzpqNTaQ2ZdhvgEKpkaOKyquYEmy8L/2UkMUx6W31UAGLJHA7dzGX4q
        ibKKSvEqg==;
Received: from [2601:1c0:6280:3f0::fee9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihFKj-00034V-UO; Tue, 17 Dec 2019 16:04:25 +0000
Subject: Re: linux-next: Tree for Dec 17
 (sound/soc/intel/boards/cml_rt1011_rt5682.o)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>
References: <20191217130829.6a66b404@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c4fd86fb-586a-0fbc-74b0-97e6b99ef2ca@infradead.org>
Date:   Tue, 17 Dec 2019 08:04:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217130829.6a66b404@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 6:08 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191216:
> 

on x86_64:

  CC      sound/soc/intel/boards/cml_rt1011_rt5682.o
../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:4: error: ‘struct snd_soc_codec_conf’ has no member named ‘dev_name’
   .dev_name = "i2c-10EC1011:00",
    ^~~~~~~~
../sound/soc/intel/boards/cml_rt1011_rt5682.c:407:50: warning: missing braces around initializer [-Wmissing-braces]
 static struct snd_soc_codec_conf rt1011_conf[] = {
                                                  ^
../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:15:
   .dev_name = "i2c-10EC1011:00",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:413:4: error: ‘struct snd_soc_codec_conf’ has no member named ‘dev_name’
   .dev_name = "i2c-10EC1011:01",
    ^~~~~~~~
../sound/soc/intel/boards/cml_rt1011_rt5682.c:407:50: warning: missing braces around initializer [-Wmissing-braces]
 static struct snd_soc_codec_conf rt1011_conf[] = {
                                                  ^
../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:15:
   .dev_name = "i2c-10EC1011:00",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:413:15:
   .dev_name = "i2c-10EC1011:01",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:417:4: error: ‘struct snd_soc_codec_conf’ has no member named ‘dev_name’
   .dev_name = "i2c-10EC1011:02",
    ^~~~~~~~
../sound/soc/intel/boards/cml_rt1011_rt5682.c:407:50: warning: missing braces around initializer [-Wmissing-braces]
 static struct snd_soc_codec_conf rt1011_conf[] = {
                                                  ^
../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:15:
   .dev_name = "i2c-10EC1011:00",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:413:15:
   .dev_name = "i2c-10EC1011:01",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:417:15:
   .dev_name = "i2c-10EC1011:02",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:421:4: error: ‘struct snd_soc_codec_conf’ has no member named ‘dev_name’
   .dev_name = "i2c-10EC1011:03",
    ^~~~~~~~
../sound/soc/intel/boards/cml_rt1011_rt5682.c:407:50: warning: missing braces around initializer [-Wmissing-braces]
 static struct snd_soc_codec_conf rt1011_conf[] = {
                                                  ^
../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:15:
   .dev_name = "i2c-10EC1011:00",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:413:15:
   .dev_name = "i2c-10EC1011:01",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:417:15:
   .dev_name = "i2c-10EC1011:02",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:421:15:
   .dev_name = "i2c-10EC1011:03",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:407:50: warning: missing braces around initializer [-Wmissing-braces]
 static struct snd_soc_codec_conf rt1011_conf[] = {
                                                  ^
../sound/soc/intel/boards/cml_rt1011_rt5682.c:409:15:
   .dev_name = "i2c-10EC1011:00",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:413:15:
   .dev_name = "i2c-10EC1011:01",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:417:15:
   .dev_name = "i2c-10EC1011:02",
               {                }
../sound/soc/intel/boards/cml_rt1011_rt5682.c:421:15:
   .dev_name = "i2c-10EC1011:03",
               {                }
make[5]: *** [../scripts/Makefile.build:266: sound/soc/intel/boards/cml_rt1011_rt5682.o] Error 1


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
