Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8CC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24401206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577156396;
	bh=MHunSC4TWQNoyQvvbVQmGGtWnGdlGPMSSzGaJcjZTII=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=EIJg+HTJxOKCT/jqRqy/Jdi+dqB5qZp5gqBvTaRleKer80ntQK1WnG7VSPhfixc2G
	 wDpTU7g5l5KS9oXEyT7p4CZGbB8pMRDXZc6Kq60myybaL4+ACCwG0DGTYLll0DhCmk
	 3wfGxU+TfglKfQyG6Rjtgrhw/poogv31KCPZ8fwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLXC7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLXC7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:59:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F419F20709;
        Tue, 24 Dec 2019 02:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577156394;
        bh=MHunSC4TWQNoyQvvbVQmGGtWnGdlGPMSSzGaJcjZTII=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=lf3WVvBOwlWomSCyRIYVJ8Pcdy66FsrtpAV8SVSgohsq2yBqmuBSJb5bOVnV064Ok
         HYPOn8iSdEHs2g3wZz5oScM8h12T1zXUW2x9RZh84sPKZfiRCIY1TCDacS5YXS2ydB
         +rLwf/8FbGpaQ7TsrqNFQsFTTUi0zbfb8ckru2Us=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190924123954.31561-4-jbrunet@baylibre.com>
References: <20190924123954.31561-1-jbrunet@baylibre.com> <20190924123954.31561-4-jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 3/3] clk: add terminate callback to clk_ops
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 18:59:53 -0800
Message-Id: <20191224025953.F419F20709@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-09-24 05:39:54)
> Add a terminate callback to the clk_ops to release the resources
> claimed in .init()
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next

