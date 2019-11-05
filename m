Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE38C47E49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0421929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SvBetFNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfKEWFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:05:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:58745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfKEWFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572991500;
        bh=2CVqbSurqJVVjA0OYR8gXO8OdEa3ms5r9NaHFZv7Two=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SvBetFNEn2/uts/8FWFpDfPuxC2yvwcCERvRfkFHv4JkgywrjydFUewcx0OtQgv2Y
         m/o4PrOv/beKOPW4Fa5mBbP8hx3T/OZKT8ETKla/RNrOl4lvzlcmsGk9QzYdUwy0R4
         VhHISApJS+5d8aIw6s1DsI7l281IKGPi4W+bhPkE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.164] ([37.4.249.112]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1iejje0Ies-00CipI; Tue, 05
 Nov 2019 23:05:00 +0100
Subject: Re: [PATCH 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org
References: <20191104135412.32118-1-nsaenzjulienne@suse.de>
 <20191104135412.32118-2-nsaenzjulienne@suse.de>
 <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
 <20191105145150.GB22987@arrakis.emea.arm.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <7b9dd4a8-bd6a-b543-4e6b-12c663161a90@gmx.net>
Date:   Tue, 5 Nov 2019 23:04:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105145150.GB22987@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:9JNq8g+rvhYmh230bjn2+Yl6kiptEJhMkbSOVyzXw+78zlOvEBb
 NShJh9pEnzi22cql5YAcjZeNmcdOZtFaIQqXTL/TMUI9FNncrr/rfC+5YbKKekKQtrCeQC1
 XAEKA5oEwAFKmkUDDJMuh6u5RebmodbozGhcyShJLBkWSXqF3DjaBXB+lcDw64fwVirE/si
 Vc5Ani6HqFdTzWo6cJQkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Mi9pCPaGV8=:VIn2in6bEWFlYe1xcDPNFE
 NQ69+raB8AJ16d0jipH56fBsw2mtewDsCgCPBX7X2Au8PuWhQ8PAVzDrbbQNWEI+6tkwb3gui
 EdqupHfNz6anGuXDlacv6kj84ziUvmDT9FViCKtm9PQ15lg17u4dvZXChCnny6WI93zVxVBVn
 011rnpSpjkbajDlGQaq8cLvtlwZv+NZAb4YsmAd9ZwtJPla+dj7631FtFoS0GJCzcqvUvxOk/
 7FQarQNKfEvjhJZI7nOCIWOZ1iKee2lYzVVOjEuHQWpVxUVN1/MGHFErU9rRA7h82NEvKT3eT
 //2/Tf4W955mJIu07u3Om99t8aA39SCMjWcSXVdcXNMoWhUMzZd3LEncuOsxQemDFxume4Gi2
 caASusANbX18bh3PXrTc1CHeOul4sFNvxpI4bQXi1YKaxy17Qof5qWYKxGtUwHDkSRsJdbyuS
 9I34I+PMDozfEg/r4Xaly0RWyGUorGQa3w3iw2y9H79HAGC/e3oxBtTwzIHXpUzSPpNTfu7Hc
 F+I7qrNWOB9eYYukwIEZ4PTyzHLtr+3OS1bG7Kibk7oe4JNiS/nwpb+xNAlKzfN9H/TsR0QFk
 N6eI4iGha+dt75htaS+Y1KOrFm3Kba+QQHj13sKqH0KQT+ln7stf2sDAqvOuLABxAidIM4r0G
 N18WafaVXkgguGMF7M413+iW96lvdNmIzISeRmt7Hfvjy3IAiHVF9/BFm1GAIpZLr0uC+TG6w
 PM1j3JiQ5U9wCCvLxLFG+wB9qEhkR7azzsypkCbPDXrXm7Fqo06wGgBXYEnaMq3SERpMR/z8u
 2zWOksqzrJqsFiEYvR6sc4PJaHKcorrRIPGBeR+0VdJ9GODJZSaKUfpBYd0aj83m3AiPhTvYK
 X6POccmrhwwnxirPlHjRKkXt7wCcvV2rY/Gs2JT9tC/sCG5I82lW1JeoetUEK9XG08cN+GN1w
 bUvH0i4QmkPHoab7X/tls7YbQGlqSe+wiNi93/+L0R0O6oOAopQsltsU9LrTvTDZ2BOsFk8ME
 8wFVWiAn5I8LLhMl6TvCV8mICEIN29MLnvwPKF3qM8o3uIeMYvxwxQpGXMG3sDj5NZ6vrtlU1
 jILRS65UGv8+cM7qsYAhWE1qJOalb43awpGlQr2q4iPvC216h/eHWQcu6QLejxQXtK0ckBC9M
 ob2ztcsjzVPcGDFyqCNpe9cnRBq0ZpDPQTylRMVAqwm0Z2JZveirzHO/0vww2TAV3HT3RJgFR
 MR6CvhSL3bjIU3z3lTezZr+/akGV4qN9QZqpfnaCnWd35KwDV0dxyngmGva8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.11.19 um 15:51 schrieb Catalin Marinas:
> Otherwise this will be queued for Linux 5.6.
> I'm happy to queue them together with your ack for 5.5, otherwise I'll
> only pick the second patch in this series.

I had a comment for this patch which should be addressed in V2. After
that i'm happy to gave my Ack.

Thanks
Stefan

>
> Thanks.
>
