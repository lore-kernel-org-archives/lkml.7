Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE80BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D502173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 05:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCMFxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 01:53:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfCMFxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 01:53:43 -0400
Received: from [192.168.1.110] ([77.4.24.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4rkF-1h5sMr38zv-001zHw; Wed, 13 Mar 2019 06:53:18 +0100
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
To:     Andrew Jeffery <andrew@aj.id.au>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        kaloz@openwrt.org, khalasa@piap.pl, lkundrak@v3.sk,
        aaro.koskinen@iki.fi, tony@atomide.com, baohua@kernel.org,
        kgene@kernel.org, krzk@kernel.org, linux@prisktech.co.nz,
        mcuos.com@gmail.com, matthias.bgg@gmail.com,
        linux-omap@vger.kernel.org
References: <1552312598-25574-1-git-send-email-info@metux.net>
 <cc4d6c18-6c94-4f0b-8c6c-139496fa49aa@www.fastmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <779e841a-ec9e-3dc5-e76a-9f5bb874e26f@metux.net>
Date:   Wed, 13 Mar 2019 06:53:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cc4d6c18-6c94-4f0b-8c6c-139496fa49aa@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GWUSfJdsmQ0gejg4rDh549rakZzZpnB9PDlaSTyUAN8U75X7oz5
 vtIYLdmT2xAlDoXnI7Y23pmZRvjAj9wn6CxVLuLbk5Wtk5fmaH4momotDO01B0+51Dy2nhn
 0yYkIlQN7Zk7KrA/xCGAS+HtLr1+/o4/MJMz6M5elcBKKWFv3f1LetEA0WDGF2J3aR81FAA
 ay1O5zT/lJaTI+yIPh+lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nBgh7SGnYi4=:uLV9MEi7TAoBdEH2mnURfG
 Svd4VbTMHtl4KuowCxPBNOOY3KPdUH4OT3/AhoBqTQ/qfvc3RJR+KVnLlmZUXjCcb0KzRruMJ
 Izg1/+DV/hVpprvD4e3b6ROm37qfOn5w1roIjTmwmq3+ab2kVDiW9uU98UcgcSx9nL2tMgxRh
 i8u7btuTQ0kDOZtcGOvh/79IdXf9f1BkcgfYk49/FwRlPk7SyaFGfz7ZrmW+lkbZudSUPoKmd
 2ZNEHPeUqb0eO0dVjSN9VIVHquNyhJheY6rrd4np2UQ1RSkpNVSjiAIaeCAjbsa0NTZVsfg+r
 9NbGFVKhrqHLaGRdIByLw/XxPGwwOpFaQ96M7uhwjswvS7GTbLd4CqcM+lc7VidRVFOqYydyG
 5k4rFadVCj2WUjyPh/A0/Vf4a3i/duQY6LreHZKiguz2ygl4TBCtl5u/qVSnSYYiVOTM+oyzy
 7/FyXodX2El0+rSU2YlqfNOXHzx4VKIkxtoPmNCs3LGA04gUzPnGLXKl185pFdAg57mb/SF4+
 phl7z4+fQ+yfEXDSvq2QxHZDR2hIhDGQyDaAuoob7Iw9hdOjKPBIEIjawqjfveWp0g4ij6yUz
 YoZUCvgcayYopTLCsdAlzgVcstPWvwJxcS+ES/H3USEFHRITALr9Pd32yKoFMER9fz6HTCwO8
 mCh0lrUeHx+5+WGlv6zVWrfFTE80j7hzBEWMhxM0CV59dGTYjSjW9cPzaB5opkcbHC5EFnVNs
 ajUhs4oirbDc96A+h7/RLtatM1r7mqyd/s4JLnED3beteSiynzJYjm0OFw8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.19 00:54, Andrew Jeffery wrote:

<snip>
> 
> For the ASPEED bits:
> 
> Acked-by: Andrew Jeffery <andrew@aj.id.au>
> 

shall I split the patch ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
