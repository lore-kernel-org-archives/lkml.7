Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF95ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445CE214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I/GOFBvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfJKXPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:15:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:53513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfJKXPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570835365;
        bh=5gB1OCM/eHUoF4+pE9h4tGD6did33KyXZQ7I6/0pCLU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I/GOFBvsXIboHGynN2mYSVXzwdIBKfSeUNMbgC3ZmtGfkTIJdQ6Zy84OQojyywLxf
         7eM0YTeCPKP1MEwJY1l+TsumTlgikYB/1d8ntKmy57Jb1TrtezT+djMB13d8BjrS3o
         cyGseQy18NpYsE96j3LAP4l51sQ2RyF9MDbRKy+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.112]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1iR33i0RZv-008cZL; Sat, 12
 Oct 2019 01:09:25 +0200
Subject: Re: [PATCH v1 3/3] ARM: dts: bcm2711: Enable GENET support for the
 RPi4
To:     matthias.bgg@kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191011184822.866-1-matthias.bgg@kernel.org>
 <20191011184822.866-4-matthias.bgg@kernel.org>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <dfe9062b-1960-f67b-2a9e-864c0680f5d3@gmx.net>
Date:   Sat, 12 Oct 2019 01:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011184822.866-4-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:hXCsfi0YzRPmoFypWyfnvbO4N7BdVxoeOYAzqfPcBP1vircEceh
 5/gp4HUDZbiVzRFNAraPoYeULEiS7pg/NXBuAyRCOMdrkpXK0OQ4Stl6pf8E52jOsx2fc5u
 qQmvIDtmTSod/RhKuofbxsYfY1Z80h4EbuwqHZFOosz8q3Cr4WkqG08p9zxoXvmye5G59jM
 Pko4MF7b2PlzF2rWIrfmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hioaaoAal40=:B4AdG8yOarUZYruTvKzKW9
 O6NhUfcFJuvBB6mewzVfICNLAu2JaVBVynV1qeVUxIlbZ753ObmgpRtOPMgt8eThT0m02EyR+
 3yFmPVLKK73vR5RuVxSz4/RaFIph129QOk+XbZk3nS3cB8VfIjtdEQBdnLRlj+DWq95AsRS5M
 JE8yhLb5koUbSkaVFzr1j7TiOekkJqXdujFGg5J41jfPufT0hC4duVn4V5sgVnVRBBffvXAVv
 Li4tHsSziRkTqQkLwRgJQCNZsKBfN1G2p9iNB3QOTFucCBUlJ8KyRiChJpEhsXIu34TCuI47V
 NebesUtHLbV2z/6pZTa9kufjyV6fNgDt7L6Z76Gp9ly5XFXoVGpkDqy0GkFOoH6shacPOm3Uq
 rY8oX2NFt5Our/vUqhO8UJd6Nlb7lVuX1I1ZQvRX5efkPyIMK4MeXZOWYNFd/49fHM6WOu1zr
 jWwJJli4OuJqeTzHxXAjDYXp54pCVVFCJFkoutjoUCJAyuIxoT/pqgje9/jcKywv+UdUpgbYK
 ud7Kql66eDPRukrt5JpZYwUzeOjVyrAkYPsSY0E0u+/glVi2BE0yuI+Lrxt/BpdLZMhVC8ckp
 MBYbrpQTFnn5pdXqQ1aw0R6OcCQPSNM41z/1xpIuKbEVRfFqZuJPssQgXy+rq+VJ0F18b5IOn
 cstZHafaMYsqYylJrOheFRum7c46HvfA+xZhFpFKheFIMHNOefFM90DIKwECxwjnRCJc+A1P5
 hFWlGLh7W27xXLJfkqAWtTec4Bj6tpo0aZ7hfon9/NFLoSWuDC5gTDVcdBeqsUOiKfSVbhfhn
 N+ByNpUvsAgjIXyQ8uow044WCrdAoNMuTUcvXhVfCp6pAZ9RdZhx/XXxNmWEFIWmkyKuIYynB
 m/43Tfr7JqlNYwqtoMcuUGEOK+j4e6aJiXDkNmbpHP3aic2rI5krd/fv3tr6BJAsQS0nquGKA
 v2KGo75smbnL31aNACNvedR8XumobvIoh+YqFDkj9R+KaM1D3HdpqqSXm1Ejt0svl3VgUnv+m
 jc9YWHX+JM0al4G3uyVHqQDZXxCW7fQ0mSWo8LSL8K/eN+9/3v0gyiJID/zMcLlDYOqSMmyMT
 lh1ZcMDGoUXwIpBY5IiaD/fB5tGQs2vJiX4+P5dRyenHg4GITUfq7v9BPMnOz0U2qSyx7Ag2b
 Yi0UneKJUl0KAfeEbGVZUR9vHEW1aSZ0gyCLnYv4B0AstLu4+F0u5q56ceOTgL3FUdXVJGPkR
 zxhRo3oUMEIT18dZOZgN8O7FD44USQk3dfla4R14H0Jtwe2yZN2pEn6NHwrA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.10.19 um 20:48 schrieb matthias.bgg@kernel.org:
> From: Matthias Brugger <mbrugger@suse.com>
>
> Enable Gigabit Ethernet support on the Raspberry Pi 4
> Model B.

I asked some questions about genet to the RPi guys [1] which are
relevant to this patch (missing clocks and interrupt, MAC address
assignment) but i didn't get an answer yet.

During my tests with a similiar patch series i noticed that the driver
won't probe without a MAC address.

How does it get into DT (via U-Boot)?

[1] -
https://github.com/raspberrypi/linux/issues/3101#issuecomment-534665860

