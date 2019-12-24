Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3253C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E902070E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577155121;
	bh=3GZ8dfQbJWPhG/4YrIDh0Ag69lL+QHGNO217O7Y9Aj8=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=h9zWFGljVrJDPMGodWYpd8jWzCGR9vU1VPUX7pJ9Bag1fIGwCbOyB1HePqMpD1zA/
	 QILVHnjXsqQDsMARDe0uUUahNawxeu1Jm54B4m49kFyJG9tHAiASBsmpRX48gEAVDD
	 rcIVmAw/QBQnczHD9OMZBSxcEqsZBwgzlARB1xTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfLXCil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfLXCik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:38:40 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCC752070E;
        Tue, 24 Dec 2019 02:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577155120;
        bh=3GZ8dfQbJWPhG/4YrIDh0Ag69lL+QHGNO217O7Y9Aj8=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=sSr0AfDgUQll2JCk8RicY0m7Xo7T+pHiLuY5KJx/exqk1HIhM03zFA03bDCeFVMer
         AbPZ/eYecAFizcNEvPd13HtVY8jy/lzR1ELhC3TtqwsrUgzOuD6hMN9Zu6IBeJGeyy
         ZsuLfLH0UrsqCA706mlP78E7RDcjUEIanW153nxI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812245-23827-4-git-send-email-tdas@codeaurora.org>
References: <1573812245-23827-1-git-send-email-tdas@codeaurora.org> <1573812245-23827-4-git-send-email-tdas@codeaurora.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1 3/3] clk: qcom: Add display clock controller driver for SC7180
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 18:38:39 -0800
Message-Id: <20191224023839.DCC752070E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-11-15 02:04:05)
> Add support for the display clock controller found on SC7180
> based devices. This would allow display drivers to probe and
> control their clocks.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

