Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2029C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9237C206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNNFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:05:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:38590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfKNNFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:05:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8575CACA0;
        Thu, 14 Nov 2019 13:05:53 +0000 (UTC)
Subject: Re: [PATCH 0/3] xen/mcelog: assorted adjustments
To:     Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <51e9faaf-cfae-7a48-2fd9-56d034ba0064@suse.com>
Date:   Thu, 14 Nov 2019 14:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a83f42ad-c380-c07f-7d22-7f19107db5d5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.19 15:43, Jan Beulich wrote:
> The 1st change is simple cleanup, noticed while preparing for the
> 2nd patch, which presents the consumer of the interface extension
> proposed in
> https://lists.xenproject.org/archives/html/xen-devel/2019-11/msg00377.html.
> The 3rd patch is sort of optional, considering that 32-bit Xen
> support is slated to be phased out of the kernel.
> 
> 1: drop __MC_MSR_MCGCAP
> 2: add PPIN to record when available
> 3: also allow building for 32-bit kernels

Pushed the series to xen/tip.git for-linus-5.5a


Juergen
