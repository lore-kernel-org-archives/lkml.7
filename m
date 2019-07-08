Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5995C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22192173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbfGHUxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:53:12 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:47343 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732038AbfGHUxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:53:12 -0400
Subject: Re: [bisected] "mm/vmalloc: Add flag for freeing of special
 permsissions" corrupts memory on ia64
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-ia64@lists.kernel.org" <linux-ia64@lists.kernel.org>
Cc:     "namit@vmware.com" <namit@vmware.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
References: <daae57de-1eff-f34a-1348-b872c44a6b4c@linux.ee>
 <096ddb2cfbe83309396c48e75648889cae68e672.camel@intel.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <d09a4305-432a-0f7b-42b0-1eb57a4b374e@linux.ee>
Date:   Mon, 8 Jul 2019 23:53:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <096ddb2cfbe83309396c48e75648889cae68e672.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am out of the office and don't have access to this hardware either. I
> will try to find someone at Intel that does to speed this up. In the
> meantime I can send you a logging patch to do some sanity checks if you
> are able to run it.

I am also cut off from testing anything - it seems the air conditioning
unit in my test site has failked for good now and the earliest I can test
anything is next week.

> I think I found your earlier mail, and it said 5.2-rc1 did not show the
> problem. I guess this wasn't the case after further testing, but 5.1
> continued to be problem free?

Yes, 5.2-rc1 was problematic in retesting, and 5.1 was OK.

I also started suspecting binutils upgrade meanwhile - I upgraded binutils
to 2.31.1-p5 in Gentoo right after booting into 5.1, but the bisection
results were finally consistent so I did not look into binutils versions
further. gcc has not changed for me recently.

-- 
Meelis Roos <mroos@linux.ee>
