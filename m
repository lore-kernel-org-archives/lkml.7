Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18370C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8C920872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 14:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfIKO2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 10:28:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44090 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfIKO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 10:28:25 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C93E154370BB;
        Wed, 11 Sep 2019 07:28:23 -0700 (PDT)
Date:   Wed, 11 Sep 2019 16:28:22 +0200 (CEST)
Message-Id: <20190911.162822.1223854296604349400.davem@davemloft.net>
To:     alexandru.ardelean@analog.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@st.com
Subject: Re: [PATCH 2/2] dt-bindings: net: dwmac: document 'mac-mode'
 property
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190906130256.10321-2-alexandru.ardelean@analog.com>
References: <20190906130256.10321-1-alexandru.ardelean@analog.com>
        <20190906130256.10321-2-alexandru.ardelean@analog.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 11 Sep 2019 07:28:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Fri, 6 Sep 2019 16:02:56 +0300

> This change documents the 'mac-mode' property that was introduced in the
> 'stmmac' driver to support passive mode converters that can sit in-between
> the MAC & PHY.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to net-next.
