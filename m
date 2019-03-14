Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB521019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=piap.pl header.i=@piap.pl header.b="nRmYgy0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCNIDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:03:24 -0400
Received: from ni.piap.pl ([195.187.100.4]:53560 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfCNIDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:03:24 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 04:03:23 EDT
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id 79C174432C4;
        Thu, 14 Mar 2019 08:58:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 79C174432C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1552550293; bh=w1fnfGqk6I7ubamWwlYbdVHCnPNFfD8bCzoMm9FymzY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nRmYgy0aEshe0oboXctOX7C7dBnnFDK2krd63oJML6b3zFqlj61JBLMQBeqDRTHSK
         wl/k9+2FzaNKy7TBZjVLilQjJSivRFqQRrboKwOrdjnmCZMEIy73+/UfM1mafLMguG
         nwK6wnoKKMYWsxQHnKBU0a+oeRZjlHLK7Tt0YYho=
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     "Enrico Weigelt\, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, andrew@aj.id.au,
        hsweeten@visionengravers.com, alexander.sverdlin@gmail.com,
        kaloz@openwrt.org, lkundrak@v3.sk, aaro.koskinen@iki.fi,
        tony@atomide.com, baohua@kernel.org, kgene@kernel.org,
        krzk@kernel.org, linux@prisktech.co.nz, mcuos.com@gmail.com,
        matthias.bgg@gmail.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
References: <1552312598-25574-1-git-send-email-info@metux.net>
Date:   Thu, 14 Mar 2019 08:58:09 +0100
In-Reply-To: <1552312598-25574-1-git-send-email-info@metux.net> (Enrico
        Weigelt's message of "Mon, 11 Mar 2019 14:56:38 +0100")
Message-ID: <m3r2b9ubu6.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 136932 [Mar 14 2019]
X-KLMS-AntiSpam-Version: 5.8.6.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 251 251 59f1bd873ce564c363d8d9090abdf2f8afae186b, {Tracking_DKIM, one}, {Tracking_marketers}, {Tracking_ sender_matches_from}, {Tracking_text_let_digits}, Auth:dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, 2019/03/13 10:54:23
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, bases: 2019/03/13 21:04:00 #9359702
X-KLMS-AntiVirus-Status: Clean, skipped
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Enrico Weigelt, metux IT consult" <info@metux.net> writes:

> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/arm/mach-ixp4xx/Kconfig  | 32 ++++++++++++++---------------

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

Though I guess things like this one could go straight to "trivial"
without all these Acked overkill.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
