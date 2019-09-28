Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07851C388F3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8832075C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfI1Jhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 05:37:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfI1Jhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 05:37:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F8EFAC93;
        Sat, 28 Sep 2019 09:37:45 +0000 (UTC)
Date:   Sat, 28 Sep 2019 11:37:54 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     <Amy.Shih@advantech.com.tw>
Cc:     <she90122@gmail.com>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, <jia.sui@advantech.com.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v6,1/1] hwmon: (nct7904) Fix incorrect temperature limitation
 register setting of LTD.
Message-ID: <20190928113754.26594064@endymion>
In-Reply-To: <20850618155720.24857-1-Amy.Shih@advantech.com.tw>
References: <20850618155720.24857-1-Amy.Shih@advantech.com.tw>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2085 15:57:19 +0000, Amy.Shih@advantech.com.tw wrote:
> (...)

I suggest you fix your system clock ;-)

-- 
Jean Delvare
SUSE L3 Support
