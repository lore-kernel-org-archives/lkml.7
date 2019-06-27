Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B41C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B974920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561647820;
	bh=9dRzJf1rsWkfWTu0ToX4+aWY5ycqC1dpc9g5Yw8Jh0Q=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=KleEWwPDr7QpYOT807ZTSnalvvM94jcU62UK9oT/CNg/Om3BrHdbm08YHIv58mY05
	 9d6J83U+cPaEYjXN6/+9CNG0RPyqdjEdomyA0h31UCEED/PW3sZJZo6gOMPJyma4gR
	 +0KtRVBs3i6Z2lXtUQfs2u+/CuGkuIARIivAaeA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfF0PDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfF0PDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:03:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A233320B1F;
        Thu, 27 Jun 2019 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561647817;
        bh=9dRzJf1rsWkfWTu0ToX4+aWY5ycqC1dpc9g5Yw8Jh0Q=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=PCdi9WNkUdNkeOnM37HFHkZUCXv33cJ0PYLTwP2k6PPaZd2eYJ1BRSGAGJF+1teGV
         qzJ3EzWvpetvUKxCcuAY1gojA8KQ0UCfkJW+OZf4+oZvv4DGmgCTVzT580x6J1rcBB
         9s6YmZhQ5kqh7JHcv/malFvvkudboo0ddeXqK8pw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu.Beznea@microchip.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 0/7] clk: at91: sckc: improve error path
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, claudiu.beznea@gmail.com,
        Claudiu.Beznea@microchip.com
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 08:03:36 -0700
Message-Id: <20190627150337.A233320B1F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-06-13 08:37:06)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Hi,
>=20
> This series tries to improve error path for slow clock registrations
> by adding functions to free resources and using them on failures.

If possible, resend this patch series in plain text. Thanks.

