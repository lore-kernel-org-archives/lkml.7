Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D4220850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCSVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:13:04 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60490 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfCSVND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:13:03 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h6M2Q-00059E-Qb; Tue, 19 Mar 2019 15:12:47 -0600
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Philip Derrin <philip@cog.systems>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
References: <20190319181357.9305-1-logang@deltatee.com>
 <20190319204253.GB17966@rapoport-lnx>
 <a9b528f1-0c4b-3894-18e1-a4999c18f4a4@deltatee.com>
 <20190319210508.GD17966@rapoport-lnx>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7f590915-d35b-c46c-a05b-c368bf9c491c@deltatee.com>
Date:   Tue, 19 Mar 2019 15:12:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319210508.GD17966@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: nicolas.pitre@linaro.org, rostedt@goodmis.org, philip@cog.systems, keescook@chromium.org, linux@armlinux.org.uk, robh@kernel.org, f.fainelli@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rppt@linux.ibm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ARM: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-19 3:05 p.m., Mike Rapoport wrote:
>> You're probably referring to [1] which was for arm64 and was redundant
>> as my patch for that architecture was already picked up by Catalin.
> 
> I've found the patch [1] I mentioned, and it was for ARM.

Ah, well, I wish knew I knew ahead of time that someone was doing my
work for me... My initial submission seemed to have been missed[1].

> AFAIK, For ARM you'd need to put it into Russel's patch tracking system [2].

Ah, I did not know this.

Logan

[1] https://lore.kernel.org/lkml/20190109202100.6968-2-logang@deltatee.com/
