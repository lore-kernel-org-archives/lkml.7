Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DCC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B252080A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmzJ42mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgAFVkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:40:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726713AbgAFVkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578346801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92IBDcXHrCniaPpYzIDDSbya4Iw/pUq5jseI84k5wbg=;
        b=RmzJ42mXVNRiBoN+aGNrqaCfRGFHO9DCLu9QiY/zhKNDN9lvTsbwlktr6oSMUqT/eUSyZx
        OM4Mn65nZtZ8PV78Fi1PDqD8ZTFMGAMmm2a/fwP1aoiSVGOWDQwrLspl3QfMFnlPrjDQ6D
        go+AMlaP5v9y4IbfXoPbakn9dU/T+jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-VkcnwEa9M_2i3M_AYQK7-Q-1; Mon, 06 Jan 2020 16:40:00 -0500
X-MC-Unique: VkcnwEa9M_2i3M_AYQK7-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 598AF10054E3;
        Mon,  6 Jan 2020 21:39:58 +0000 (UTC)
Received: from localhost (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0154D60E1C;
        Mon,  6 Jan 2020 21:39:55 +0000 (UTC)
Date:   Mon, 06 Jan 2020 13:39:54 -0800 (PST)
Message-Id: <20200106.133954.516759492863458363.davem@redhat.com>
To:     christophe.jaillet@wanadoo.fr
Cc:     pablo@netfilter.org, laforge@gnumonks.org,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gtp: simplify error handling code in
 'gtp_encap_enable()'
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200105173607.5456-1-christophe.jaillet@wanadoo.fr>
References: <20200105173607.5456-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun,  5 Jan 2020 18:36:07 +0100

> 'gtp_encap_disable_sock(sk)' handles the case where sk is NULL, so there
> is no need to test it before calling the function.
> 
> This saves a few line of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to net-next.

