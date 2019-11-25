Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44047C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C3420679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKYG7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:59:12 -0500
Received: from verein.lst.de ([213.95.11.211]:34427 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKYG7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:59:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5350E68BFE; Mon, 25 Nov 2019 07:59:07 +0100 (CET)
Date:   Mon, 25 Nov 2019 07:59:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 7/8] nvme: hwmon: switch to use <linux/temperature.h>
 helpers
Message-ID: <20191125065907.GA29695@lst.de>
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com> <1574604530-9024-8-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574604530-9024-8-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2019 at 11:08:49PM +0900, Akinobu Mita wrote:
> This switches the nvme driver to use kelvin_to_millicelsius() and
> millicelsius_to_kelvin() in <linux/temperature.h>.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
