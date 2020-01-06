Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EDB2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGMOjc58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgAFVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:47:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726695AbgAFVrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578347240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVymaL2YR0nFZX0XYU+2dgAryYfSl5ztE4IIW1BSF58=;
        b=eGMOjc58zkM3U+7bNnKBdvCHCjxyhGoIjIM/pYrpsFWt4BnnmkOQx728N2pS6Mn7cBI7T0
        9/ZqZyFAZsrXDkhWKwCCA4DOAjzlkhUua963izjzP/xl31cW+Ju8Oq5qWpAzRMmmGUjqMX
        9joMNyp7RjUwZKPkp6gqNJ9ugdu+28A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-TCcTQo0nM-aMoZc71vjK0A-1; Mon, 06 Jan 2020 16:47:15 -0500
X-MC-Unique: TCcTQo0nM-aMoZc71vjK0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C0D3801E77;
        Mon,  6 Jan 2020 21:47:13 +0000 (UTC)
Received: from localhost (ovpn-112-4.rdu2.redhat.com [10.10.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B113E85882;
        Mon,  6 Jan 2020 21:47:10 +0000 (UTC)
Date:   Mon, 06 Jan 2020 13:47:09 -0800 (PST)
Message-Id: <20200106.134709.1814886107715198121.davem@redhat.com>
To:     wens@kernel.org
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mripard@kernel.org, wens@csie.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH netdev] net: stmmac: dwmac-sunxi: Allow all RGMII modes
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200106030922.19721-1-wens@kernel.org>
References: <20200106030922.19721-1-wens@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon,  6 Jan 2020 11:09:22 +0800

> Maybe CC stable so future device trees can be used with stable kernels?

Please read the netdev FAQ, you should never CC: stable for networking
changes.

