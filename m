Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF123C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846702072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ujw9mmvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgAFVqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:46:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58149 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726742AbgAFVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578347170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LNwRHyI2AjpDdbwvKWA3E8D6dUXFXM87APIN8g0WhXQ=;
        b=Ujw9mmvCDe6FQNuEx9s8F9ntY9p1bQ2JLQWS7k8f5mI8hSoRrnHOJ4HwjSJ+IiZYPPCVT3
        cA/sPvxLVNyyYe0ZmWUNBc9uXtVqTbj9wuR1T93hRpEdHklM+mtEiS4cfzAQbiZZkUp0c7
        jzEFw7MqIH9UPWjFCSYMIRkSpuHUq9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-3Mf2JKw9MZisqS9uRU7tBA-1; Mon, 06 Jan 2020 16:46:06 -0500
X-MC-Unique: 3Mf2JKw9MZisqS9uRU7tBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90D72801E6C;
        Mon,  6 Jan 2020 21:46:01 +0000 (UTC)
Received: from localhost (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C192160CD1;
        Mon,  6 Jan 2020 21:45:58 +0000 (UTC)
Date:   Mon, 06 Jan 2020 13:45:57 -0800 (PST)
Message-Id: <20200106.134557.2214546621758238890.davem@redhat.com>
To:     jiping.ma2@windriver.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: debugfs entry name is not be changed when udev
 rename device name.
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200106023341.206459-1-jiping.ma2@windriver.com>
References: <20200106023341.206459-1-jiping.ma2@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiping Ma <jiping.ma2@windriver.com>
Date: Mon, 6 Jan 2020 10:33:41 +0800

> Add one notifier for udev changes net device name.
> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>

This doesn't apply to 'net' and since this is a bug fix that is where
you should target this change.

Thank you.

