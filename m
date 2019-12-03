Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4680EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A53F2070A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A9Ap3tbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCNWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:22:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:34973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLCNWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575379340;
        bh=Yq7dh2H2HbqzSB8iffyguOwW3+7XGnKb8rcDdey5ZXw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=A9Ap3tbRijOE/s3ChROMRbJ5wkkaXi9cfsQJlVz9Ts8px8r+NcutPLM2kflpE8J19
         lS4s3UA88kcCDgAWW13gKmpvzrCSTQ53kbgGLhufbnHciiLlCv5PKQmGcLovKR3DAD
         IOfktlUejkcDquNlJ1VFgxVLI5CD308EL9ncy7lM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zaphod.peppercon.de ([212.80.250.50]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1iH9ua2kmq-00YATE; Tue, 03
 Dec 2019 14:22:20 +0100
Subject: Re: [PATCH] ARM: dts: at91: Reenable UART TX pull-ups
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20191128100629.10247-1-inguin@gmx.de>
 <8e8dfc02-bdab-d6f1-f6e9-e1dba7e38bfd@axentia.se>
From:   Ingo van Lil <inguin@gmx.de>
Message-ID: <5b7ff913-bca7-2695-ab72-76350778a577@gmx.de>
Date:   Tue, 3 Dec 2019 14:22:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.21)
 Gecko/20090320 Fedora/2.0.0.21-1.fc10 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
MIME-Version: 1.0
In-Reply-To: <8e8dfc02-bdab-d6f1-f6e9-e1dba7e38bfd@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nWRfkGZTvSATSzYu6W0zbX1SUX62nVGxDiV3yNadfZ3Wu0DB2J8
 AeOBeQlMLq1EQqyurma/lZP0IXtrgE1+woInNLjOoONCxn2UHmtoPuGQ5hheZLtBwX8nCVU
 ujZRBLfz/zegEsKkMRVMV23zNk8QgJNJnusMSxqfx3dDYD8/k/fYSQLNmOeXhn6nYAwc7f/
 MKThSwFhlWogOTf0gKHEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OIHbv3vXje8=:5g1Pr1QZWf8Hk3Wc7uQYrT
 R04Zbm6Zm8oC8biOkQQCBB+N50aZd6XYmzavzDnZjVasmBEWF8CsLXoAghlKkSC0EN1VeXGRU
 c2zfSPS+omXkupqHJwNDOOpOq9K+jZ939iDuuGUDfTgfvP2xzHfpAnFvMaTlM5o1R6/GSa32X
 RCWxO87D8PlBauYyLzSJsdiPZpFC8EsvAHeMKcoYHHAnFD1h8J6/fLsCrRcb1LK/mKlgt74+v
 sITZM8TiqrXbCX0u6H/46ux25qJolNOQSXIKdKzQyFNKPb4IFb/MP/mvhUpFWl+o4Z+TDfo6T
 /nyMF0HoDUWP4rNFJwAG/4ONI/9xw0PYCkEu1F0UnXyo3SkJv7CXGCHrAIkJGXG+y4Z6yHLLk
 w+V1NzTQqz0M6SuCvf9CoF9iyBpdRQHF77mi9KPaej5HHNC8ASIcVKd+vDSC0HDR4aJZ8UOHD
 ALr3cEwqsAx0hg3NJoNb1Ubfl4LqNHdVAyTMhZ8vhyWqPuh9DPocOS4MfDlGDfKL0OVA22Dpc
 yZAwwlNiSJymO88L8+gltO8rBiiqggwRWOyf/0fyO2J5pt1E3Uc9Fa5OSyWol2SUmXuwjKASc
 Wfw/PISWftRAGyOX2R3yvZ+RIn2evJ/Mi9ZAk8WiYG5PAWDIC81e/Ggg+6rX7NNg0DmoXUBn8
 y9zLDM2zEQEoYf0UnzujVkYFM8rLH+B+QBfqNJTvUZKslo83fzkIlvUorHSvHnW+S06XdYfYb
 kyHjI1DYrErBPlOELGHqcDnpFm0DFs8yOozyXyt/ePenPpPKfsEuo/QxbhOOdgEhJJOyZn+H4
 fU10AO0ochk/00XQ772owR3+jLZUvkyojJ8aY3C3nuVh3PkYUFT87nURc4f060qjTUlNpj/Bq
 MkphgRVYXQ6vVgj2XOzwUTSx5Z/fWD9uM1Bjbkilk1RgZQxqVfeRmr0wHXmZqSTbNBaUlAF0t
 pQO1+3Mj4aUMBvuWyIyFEzpy2HpVXDNnkt8h3cARVzltNAIR9b5cgrdy7epqa6TFp2GH4JcZY
 POyHktD9E31que8GrG/xnqmjycAP/uCilblpAsxOWXCqCdXEC3s03y47nf6xJlDL6xl+7I7+V
 1o4dpqxLAixzdESXJNzfgZTdjpsisNDuBVahb52mnqOHxrdbsGYdPbVOLZrC98xKm1ifwgrv/
 ybccmHym0dPfJnoBSZEScht94aSoQYarbh+N1UWN8QZrL5uxuSXtAlWvCGRXj2WmS7UjD7VFf
 RlKTLIj/wRqGZPED6v+aa58RIJ8XfdGZgdgchKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 2:04 PM, Peter Rosin wrote:

> Sounds reasonable, and sorry for the breakage. However, perhaps a proper
> fixes tag (with the prescribed length of the commit hash) should be in
> there somewhere?

Sounds good, I will add one.


> Also, I think the same kind of change was made to the barebox bootloader
> at about the same time. Is there a fix for that queued up as well?

Sorry, I'm not familiar with Barebox. We use u-boot.

Regards,
Ingo
