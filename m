Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6071C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFFD20650
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 06:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J00Wn5Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLGBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:01:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbfKLGBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573538507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Inq6FWcoiOjRkPM+C10tqpzJKwC9a+cKBaqM1tHrej4=;
        b=J00Wn5Yv27K40PULMvT4PsSvalGTXt/HOZATqp+c+MvL6ifIU3zfoCbJudn6Ein1jW/HtB
        nwuwF3kqxODmayiKfL2QCO3Mp+HjaHZfRyl6APDla1k3VkmcXkFEF9+jA2PcvKkTCbToww
        6GZsmmQ0x3ZpPvhPHbH6itOgFlXvSok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-h6pO4xmxO8qSTK_XoEGZ8Q-1; Tue, 12 Nov 2019 01:01:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10A53107ACC4;
        Tue, 12 Nov 2019 06:01:42 +0000 (UTC)
Received: from localhost (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80E1428D19;
        Tue, 12 Nov 2019 06:01:39 +0000 (UTC)
Date:   Mon, 11 Nov 2019 22:01:37 -0800 (PST)
Message-Id: <20191111.220137.766852670780646785.davem@redhat.com>
To:     yuehaibing@huawei.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        mail@david-bauer.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdio_bus: Fix PTR_ERR applied after initialization to
 constant
From:   David Miller <davem@redhat.com>
In-Reply-To: <20191111071347.21712-1-yuehaibing@huawei.com>
References: <20191111071347.21712-1-yuehaibing@huawei.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: h6pO4xmxO8qSTK_XoEGZ8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 11 Nov 2019 15:13:47 +0800

> Fix coccinelle warning:
>=20
> ./drivers/net/phy/mdio_bus.c:67:5-12: ERROR: PTR_ERR applied after initia=
lization to constant on line 62
> ./drivers/net/phy/mdio_bus.c:68:5-12: ERROR: PTR_ERR applied after initia=
lization to constant on line 62
>=20
> Fix this by using IS_ERR before PTR_ERR
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 71dd6c0dff51 ("net: phy: add support for reset-controller")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.

