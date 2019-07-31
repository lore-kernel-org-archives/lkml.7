Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82065C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5D620651
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfGaK7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfGaK7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:59:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA844ACC4;
        Wed, 31 Jul 2019 10:59:29 +0000 (UTC)
Date:   Wed, 31 Jul 2019 12:59:27 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
Message-ID: <20190731105927.GA5092@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190725145719.8344-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725145719.8344-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> In delayedwork_callback(), logi_dj_recv_query_paired_devices
> may return positive value while success now, so check it
> correctly.

> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
