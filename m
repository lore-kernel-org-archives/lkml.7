Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA235C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B752720B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561647460;
	bh=V7tnhDpdCEtH0xy4BaUun+rbJC5qQflf0ihlbDGxrYw=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=TrGwQgEcJEEf6a2N8aWx/kd8dsml9rXxMsXaAlBm7shTCfjjVhkhJE6BDfjXaBG9Q
	 MbKxTtF2y54JZLyaZ+KZ2GgFjj1Pp9p7P7l3dW/Or6wB8RG+yOwyfVTq982c/46jPU
	 ttMW4e07rsSAfh0oT9ky1dL+UCZgdlaZR8JivmrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfF0O5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfF0O5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:57:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42BD52086D;
        Thu, 27 Jun 2019 14:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561647458;
        bh=V7tnhDpdCEtH0xy4BaUun+rbJC5qQflf0ihlbDGxrYw=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=R0kBGt0GTuwC1Zo9rNGZHKLtrEYrtoQVP7zIoYYbLiFkAPc6AUs1WbNxw9j612hz7
         DBT+YCVJggrBEzdC/GFIogNnciL3PH7tP2xMKT3nLs61+Iu6dRTHwL5vkPOqH9LU/E
         CszflHmvGLcG9DecNWSBoIU5+AvkYk4KBmlHgg7c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
References: <1561646841-7663-1-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mark.rutland@arm.com, mturquette@baylibre.com,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 0/4] add slow clock support for SAM9X60
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 07:57:37 -0700
Message-Id: <20190627145738.42BD52086D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 07:47:17)
> Hi,
>=20
> This series add slow clock support for SAM9X60. Apart from previous IPs, =
this
> one uses different offsets in control register for different functionalit=
ies.
> The series adapt current driver to work for all IPs using per IP
> configurations initialized at probe.
>=20
> Stephen,
>=20
> I send a new version of this since I'm not seeing the patches on clk-next
> and I though you may had issues with the previous version of this series.

Ok thanks. I see that you've fixed it to send plain text. Great! But I
already applied the other patches so I'll just keep what I had. Should
be pushed out to clk-next today.

