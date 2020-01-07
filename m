Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBE8C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0C72075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgAGH3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:29:39 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:59622 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgAGH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:29:39 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iojIh-00023F-2M; Tue, 07 Jan 2020 08:29:15 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 0077TENG016760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 7 Jan 2020 08:29:14 +0100
Subject: Re: [PATCH 2/5] regulator: mp8859: add config option and build entry
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200106211633.2882-1-m.reichl@fivetechno.de>
 <20200106211633.2882-3-m.reichl@fivetechno.de> <6648097.OAGuGJg3er@diego>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
Message-ID: <4ec799d7-9404-f61d-3db7-446fb8bd45a2@fivetechno.de>
Date:   Tue, 7 Jan 2020 08:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <6648097.OAGuGJg3er@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1578382178;468f51eb;
X-HE-SMSGID: 1iojIh-00023F-2M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,
Am 06.01.20 um 22:22 schrieb Heiko Stübner:
> Am Montag, 6. Januar 2020, 22:16:25 CET schrieb Markus Reichl:
>> Add entries for the mp8859 regulator driver
>> to the build system.
>> 
>> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> 
> this still should get merged into patch1 :-)

Will merge them in next version.

> 
> Heiko
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

Gruß,
-- 
Markus Reichl
