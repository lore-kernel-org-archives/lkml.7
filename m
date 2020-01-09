Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0588C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC529206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgAIU0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:26:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51906 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbgAIU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:26:10 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 69A94CED0A;
        Thu,  9 Jan 2020 21:35:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] bluetooth: btbcm : Fix warning about missing blank lines
 after declarations
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200109044019.53134-1-d.changqi@gmail.com>
Date:   Thu, 9 Jan 2020 21:26:08 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B29AE57C-68FB-459A-B64E-47C7C2DBAE67@holtmann.org>
References: <20200109044019.53134-1-d.changqi@gmail.com>
To:     d.changqi@gmail.com
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changqi,

> This patches fixes two warnings of checkpatch.pl, both of the type
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Changqi Du <d.changqi@gmail.com>
> ---
> drivers/bluetooth/btbcm.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

