Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9C620854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442523AbfJRLPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:15:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55795 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfJRLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:15:25 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iLQE7-0000Ib-CQ; Fri, 18 Oct 2019 12:15:23 +0100
To:     linux-sparse@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Subject: sparse: __pure declaration only
Organization: Codethink Limited.
Message-ID: <09d824ac-5371-830e-466d-7f78ccdae065@codethink.co.uk>
Date:   Fri, 18 Oct 2019 12:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing the following sparse warnings where the declaration
has __pure but the implementation does not.

> lib/bitmap.c:62:6: error: symbol '__bitmap_or_equal' redeclared with different type (originally declared at ./include/linux/bitmap.h:123) - different modifiers

is this a valid warning? if not, should sparse be ignoring these.

Note:
> include/linux/bitmap.h:extern bool __pure __bitmap_or_equal(const unsigned long *src1,
> lib/bitmap.c:bool __bitmap_or_equal(const unsigned long *bitmap1,


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
