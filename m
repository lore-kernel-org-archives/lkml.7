Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4530C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B1420717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217595;
	bh=YM7bN6OkDwrIQlh7YN/2zG+tYjUZv215hsNTLjxam6c=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=mOmzGVxzL3FLl4bO9PFdK5kG/6QURBbPbY1HJfdYhezIyZOrVuKIo8O8PRL6RCJuE
	 ZzxBkmpfR/G+zPoPsTeYGcrwy8XZ80+tCHKHTzItGed1YeseYHTMtw9CKOA5un2682
	 hZ1a4QJrqI/8Mw988O4Sa5CmAfDjiiIWz0Qy9ds8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfDYSjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfDYSjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:39:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112772053B;
        Thu, 25 Apr 2019 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217593;
        bh=YM7bN6OkDwrIQlh7YN/2zG+tYjUZv215hsNTLjxam6c=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Ch4uZuqPS/pFoV2Vrh5Hmum4McTtQmsZlUEnWLiJcpuxZwScWpp92qnjNbbj3CFZ1
         cepXYTmVLzNNTftLFoET4CjftHiNCTOhLyXG9u72By9+Fdcok3fQWdmPjOV+xWyE1o
         mWl0OJi09SKKoO0xqX5aOq84xvIFbuo+6UIUch3A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556185682-26205-1-git-send-email-vabhav.sharma@nxp.com>
References: <1556185682-26205-1-git-send-email-vabhav.sharma@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] clk: qoriq: increase array size of cmux_to_group
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Message-ID: <155621759164.15276.11525429390002850816@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:39:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vabhav Sharma (2019-04-25 02:47:48)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>=20
> Increase size of cmux_to_group array, to accomdate entry of
> -1 termination.
>=20
> Added -1, terminated, entry for 4080_cmux_grpX.
>=20
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next and I added space around the +

