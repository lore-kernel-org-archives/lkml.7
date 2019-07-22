Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D003DC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DE62199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563831013;
	bh=F1h4fbko3GoKghOyB8V2PZNI7J3t6w8bvytUqOh9UCI=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=FgPt72lg5OQbNh+4IaWXP1Z7lhhe9SQLsIOI3zPYODkkCzil3UoibspkCdmJyao5P
	 GZIb4Pk25JnKOeE/g/MUoGZRqpjTTxgshF/5+Iak8bygHGjuV1Q8OeH1ylTqGXQByD
	 QxnviSeFloc/grFzegVaJDEJfDVtKfsRLBrkXwFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbfGVVaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731852AbfGVVaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:30:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C64421900;
        Mon, 22 Jul 2019 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563831011;
        bh=F1h4fbko3GoKghOyB8V2PZNI7J3t6w8bvytUqOh9UCI=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=lKNFptlRtG+jdk5J6/RG/mxeYrChsOZgEG7uWSrdIecM4fgYTLnaNjW1FabV+PB3f
         P/W2bulFx9XZidJ6MqJX97/eJGtsTM14z4p1kAQl0ptKDcUm133f0Ab+5tZe9QTIl3
         vKUZtYRXL7ZiHsd17KAGufwcFQySmMVAk1SF1uQA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190708154730.16643-11-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com> <20190708154730.16643-11-sudeep.holla@arm.com>
Subject: Re: [PATCH 10/11] firmware: arm_scmi: Drop config flag in clk_ops->rate_set
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:30:10 -0700
Message-Id: <20190722213011.0C64421900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2019-07-08 08:47:29)
> CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
> number of pending asynchronous clock rate changes supported by the
> platform. If it's non-zero, then we should be able to use asynchronous
> clock rate set for any clocks until the maximum limit is reached.
>=20
> In order to add that support, let's drop the config flag passed to
> clk_ops->rate_set and handle the asynchronous requests dynamically.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

