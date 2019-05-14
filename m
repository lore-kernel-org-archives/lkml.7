Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD83CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7988920881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfENNZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:25:26 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:47825 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbfENNZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:25:26 -0400
Received: from [109.168.11.45] (port=43160 helo=[192.168.101.64])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1hQXQj-00FKZY-6B; Tue, 14 May 2019 15:25:17 +0200
Subject: Re: [PATCH] net: macb: fix error format in dev_err()
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20190514071450.27760-1-luca@lucaceresoli.net>
 <20190514123510.GA5892@lunn.ch>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <d437edfc-0810-c91d-a0cc-cf16eb79c438@lucaceresoli.net>
Date:   Tue, 14 May 2019 15:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514123510.GA5892@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 14/05/19 14:35, Andrew Lunn wrote:
> On Tue, May 14, 2019 at 09:14:50AM +0200, Luca Ceresoli wrote:
>> Errors are negative numbers. Using %u shows them as very large positive
>> numbers such as 4294967277 that don't make sense. Use the %d format
>> instead, and get a much nicer -19.
> 
> Hi Luca
> 
> Do you consider this a fix? If so, it should be against David net
> tree, and have [PATCH net] in the subject. It would also be good to
> add a Fixes: tag.

Thanks for the hint! I just resent with these changes.

You can ignore this patch.
-- 
Luca
