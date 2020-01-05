Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9FC33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0887C207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578253690;
	bh=bK8BeYLfzpQmd0AwksiZZHKDK2SOLa9gpbO+s9vIMfo=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=JUjLLIWOtJWjwmdUXh43LGOa3/scR7SDM5OUK7uxaKYxCplsD4aci9WG+7iHQGQ0G
	 ADj48y5T9pibsjlO0NXmj3dxRKBERR5lOetzlsVUMIaR3evW5QplrFz/8bRdmMmcHo
	 Qzsi28ft3KpGdAizQWOsq3cLtiWkGKGP5ec3v7qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAETsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 14:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgAETsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:48:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50FD206E6;
        Sun,  5 Jan 2020 19:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578253688;
        bh=bK8BeYLfzpQmd0AwksiZZHKDK2SOLa9gpbO+s9vIMfo=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=K3jUHHJo4xT+L7JtFEna5T2ofEBB8T1DwKQ9roazsV8XJIFhD27SzLIU7+cHxeXHz
         tv5aM/2GBSHz4OE2O9m1XJyxK35jbVycwE0feSajj3OrR8AfdeGP88MNnZF7DezwdF
         P3uyPrMrVD3NEn6ZV4zuQYdyGAEYNQT1a6aZGa/0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5f8a1c4fee04db1c01abfba88bec223c1c6b76f5.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com> <5f8a1c4fee04db1c01abfba88bec223c1c6b76f5.1574922435.git.shubhrajyoti.datta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     devel@driverdev.osuosl.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v3 03/10] clk: clock-wizard: Fix kernel-doc warning
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 11:48:07 -0800
Message-Id: <20200105194807.E50FD206E6@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting shubhrajyoti.datta@gmail.com (2019-11-27 22:36:10)
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>=20
> Update description for the clocking wizard structure
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

