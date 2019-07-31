Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13D3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D412089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfGaLGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:06:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfGaLGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:06:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24455AF78;
        Wed, 31 Jul 2019 11:06:31 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:06:29 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
Message-ID: <20190731110629.GB5092@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190725145719.8344-1-yuehaibing@huawei.com>
 <20190731105927.GA5092@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731105927.GA5092@dell5510>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > In delayedwork_callback(), logi_dj_recv_query_paired_devices
> > may return positive value while success now, so check it
> > correctly.

> > Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
OK, not only it didn't fix problems with logitech mouse (see below),
but removing mouses USB dongle effectively crashes kernel, so this one probably
shouldn't be applied :).

[  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with error 7
[  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback: logi_dj_recv_query_paired_devices error: 7

Kind regards,
Petr
