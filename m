Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA31EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56112084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfEMQqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:46:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39898 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfEMQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:46:33 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3747314E266A1;
        Mon, 13 May 2019 09:46:33 -0700 (PDT)
Date:   Mon, 13 May 2019 09:46:32 -0700 (PDT)
Message-Id: <20190513.094632.2251179341102416171.davem@davemloft.net>
To:     jay.vosburgh@canonical.com
Cc:     jarod@redhat.com, linux-kernel@vger.kernel.org, vfalico@gmail.com,
        andy@greyhouse.net, netdev@vger.kernel.org
Subject: Re: [PATCH] bonding: fix arp_validate toggling in active-backup
 mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <6720.1557765810@famine>
References: <26675.1557528809@famine>
        <2033e768-9e35-ac89-c526-4c28fc3f747e@redhat.com>
        <6720.1557765810@famine>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 May 2019 09:46:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Vosburgh <jay.vosburgh@canonical.com>
Date: Mon, 13 May 2019 09:43:30 -0700

> 	That would be my preference, as the 29c4948293bf commit looks to
> be the change actually being fixed.

Sorry I pushed the original commit message out :-(

But isn't the Fixes: tag he choose the one where the logic actually
causes problems?  That's kind of my real criteria for Fixes: tags.
