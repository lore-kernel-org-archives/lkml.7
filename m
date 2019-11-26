Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D4EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA202064B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKZWEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:04:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfKZWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:04:14 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D970B14D44125;
        Tue, 26 Nov 2019 14:04:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 14:04:12 -0800 (PST)
Message-Id: <20191126.140412.327150078421405319.davem@davemloft.net>
To:     tranmanphong@gmail.com
Cc:     alexios.zavras@intel.com, allison@lohutok.net, benquike@gmail.com,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com, tglx@linutronix.de
Subject: Re: [Patch v2 0/2] Fix -Wcast-function-type usb net drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191126135413.19929-1-tranmanphong@gmail.com>
References: <20191125.110708.76766634808358006.davem@davemloft.net>
        <20191126135413.19929-1-tranmanphong@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 26 Nov 2019 14:04:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>
Date: Tue, 26 Nov 2019 20:54:11 +0700

> Change log with v1:
>  - Modify suffix of patch subject.
>  - Did the checkpatch.pl (remove the space, add a blank line).

Series applied, thanks.
