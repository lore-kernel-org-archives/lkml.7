Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE9C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F292086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561499507;
	bh=zJpQRqXOj6DwCE1GBSj6EfyABK5ll9X4V3VtqR4B+8I=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=p4S9PWq2jYUdXXQduUy8CvDdGnaTYn5D1IR2ai3plu0a9yClvO+MDIRPx2tkkawIT
	 7OBctFYwxIWpFgNi0vNH5gNExfe/Oqk0lHErITrYYDG4AQiJmd6VTi54ooeHowWj9e
	 biCAbK7QDP+xsPKhF2TVOEkhfGaGGXP9qjcnRsVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFYVvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfFYVvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:51:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5B82086D;
        Tue, 25 Jun 2019 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561499504;
        bh=zJpQRqXOj6DwCE1GBSj6EfyABK5ll9X4V3VtqR4B+8I=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=FixI2VzZO5Nhs1oXo3I3h7qsVVQtRa6pqivxgXefsZnDxrFJcrRpiaa1bum2lMwwu
         J6tUdYZ09Z32NzeTSCit8EbD76vmPRbpIrx8Iscswky8JOENRfIg3dx0FRcJLLPugr
         p6QEsBAua1Xs6JT0+J267jkN5VHR8Pj+vV/P5yA4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190617135602.32766-1-geert+renesas@glider.be>
References: <20190617135602.32766-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH trivial] clk: Grammar missing "and", Spelling s/statisfied/satisfied/
Cc:     Jiri Kosina <trivial@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 14:51:43 -0700
Message-Id: <20190625215144.1A5B82086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-06-17 06:56:02)
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next

