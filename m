Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2873C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DF820731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAFU6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:58:08 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:39162 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbgAFUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:52:16 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1ioZMD-0005xN-TP; Mon, 06 Jan 2020 21:52:13 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (pD9E89450.dip0.t-ipconnect.de [217.232.148.80])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 006KqCX5031411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 6 Jan 2020 21:52:13 +0100
Subject: Re: [PATCH 1/5] regulator: mp8859: add driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20200104153321.6584-1-m.reichl@fivetechno.de>
 <20200104153321.6584-2-m.reichl@fivetechno.de>
 <20200106204520.GD6448@sirena.org.uk>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <1216f846-0a3b-70f0-70b9-49f8fa90720d@fivetechno.de>
Date:   Mon, 6 Jan 2020 21:52:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200106204520.GD6448@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1578343936;39f186da;
X-HE-SMSGID: 1ioZMD-0005xN-TP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.01.20 um 21:45 schrieb Mark Brown:
> On Sat, Jan 04, 2020 at 04:32:45PM +0100, Markus Reichl wrote:
>> The MP8859 from Monolithic Power Systems is a single output DC/DC
>> converter. The voltage can be controlled via I2C.
> 
> I have patches 1, 2 and 4 with no cover letter or other information
> about dependencies.  What's the story there?
> 
I used scripts/get_maintainer.pl on the single patches, will resend to 
a combined list.

> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
