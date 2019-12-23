Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC29C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC50D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLWQXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:23:24 -0500
Received: from smtp.inetstar.ru ([5.188.112.44]:38425 "EHLO smtp.inetstar.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfLWQXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:23:23 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Dec 2019 11:23:22 EST
Received: from [10.0.0.2] ([193.107.193.43])
  (AUTH: LOGIN work2017, SSL: TLS1.2,128bits,ECDHE_RSA_AES_128_GCM_SHA256)
  by smtp.inetstar.ru with ESMTPSA; Mon, 23 Dec 2019 19:18:20 +0300
  id 00000000009E2F72.000000005E00E8CC.00007E13
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?B?0KHQtdGA0LPQtdC5INCa0LDQvNC10L3QtdCy?= 
        <nilfs19@inetstar.ru>
Subject: RE: BUG: unable to handle kernel NULL pointer dereference at
 00000000000000a8 in nilfs_segctor_do_constr
Message-ID: <b979e974-93a0-f418-6bfb-95b600769953@inetstar.ru>
Date:   Mon, 23 Dec 2019 19:18:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I also found a similar error in kernel
4.19.85
4.19.88
5.4.6

I generally can not use NILFS2 partitions for more than 2 minutes.

Which I try write to partition I see:

BUG: kernel NULL pointer dereference

Call trace:
__test_set_page_writeback+0x2d6/0x300
nilfs_segstor_do_construct+0xcc9/0x1220 [nilfs2]

Screenshot:

https://hsto.org/webt/87/md/lc/87mdlc4jqvxucjon7jai4pcwy34.jpeg
https://hsto.org/webt/sf/rs/uk/sfrsukkoq60liw0btmikpzwrpom.jpeg

https://hsto.org/webt/g7/cw/fx/g7cwfxijgykq43tjc3-vx48cpui.jpeg
https://hsto.org/webt/ft/i4/wy/fti4wyofwz1iiqkfhlwrghc-jtk.jpeg

