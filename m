Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0A9C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9951B20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGBJls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:41:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfGBJlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:41:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AE8AB039;
        Tue,  2 Jul 2019 09:41:46 +0000 (UTC)
Message-ID: <1562059675.5819.12.camel@suse.com>
Subject: Re: [PATCH] usb: image: microtek: Unneeded variable: "err". Return
 "0" on line 616
From:   Oliver Neukum <oneukum@suse.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 02 Jul 2019 11:27:55 +0200
In-Reply-To: <20190701175958.GA9826@hari-Inspiron-1545>
References: <20190701175958.GA9826@hari-Inspiron-1545>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 01.07.2019, 23:29 +0530 schrieb Hariprasad Kelam:
> Fix below issue reported by coccicheck
> drivers/usb/image/microtek.c:569:5-8: Unneeded variable: "err". Return
> "0" on line 616
> 
> We can not change return type of mts_scsi_queuecommand_lck as it is part
> of DEF_SCSI_QCMD
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
