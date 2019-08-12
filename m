Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C4C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E87206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565637102;
	bh=E/Wq7i7xnIxt1gJKCZ82QanfLVuebUWCuy1K24B+FMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FRA2lLWL8PZaPIpiCwpsL3agS0HOVGFZHIUW6B09BsFU+y3FmzgJqOAfcIF6Viko1
	 QTfC84dW6pEVRSzYkBmEORZVoODO6TeCWkjY6RiBgpikM/JKZo/0sMryjhv1KAnb02
	 T4UkoBEfODPp0W3A96AuuLjn+jkQ1P/1C3NdH4Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfHLTLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLTLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:11:40 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFE4208C2;
        Mon, 12 Aug 2019 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565637099;
        bh=E/Wq7i7xnIxt1gJKCZ82QanfLVuebUWCuy1K24B+FMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=treak2G8MrbmObg8FSSFRSwB7hajX9l7l97PeEBgEdM/rpYdzbDA/0/OLeqsgg2qU
         KKeMhhzubR55UZHsQlN1wJmK2EcT4cTbc3Qci1JDGQox8SEM4HqQml5jf7ih485rmi
         GzvXzfi6cTXv86Tepm51ut18EIkOqAVRXDCcMW38=
Received: by mail-qt1-f175.google.com with SMTP id t12so15364533qtp.9;
        Mon, 12 Aug 2019 12:11:39 -0700 (PDT)
X-Gm-Message-State: APjAAAXdUDovj7ilgCQ9dcZSIkrDGBd0SD/sNJQkXdVMEagFS0Xj2QR7
        1UJmzthhgDgwDGVM4wdDcTs+2uqNyeM/XtjEyA==
X-Google-Smtp-Source: APXvYqwy7GVmLeGMFfbnCU9KfMy2d+Cst1XuCcbjR1Nxmy2vbL1Eh3xsRpA80dmnLum7eCTeYkaqBTIWT6xIjJgsq9c=
X-Received: by 2002:ad4:4301:: with SMTP id c1mr10974792qvs.138.1565637099006;
 Mon, 12 Aug 2019 12:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190812025242.15570-1-wangzqbj@inspur.com>
In-Reply-To: <20190812025242.15570-1-wangzqbj@inspur.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:11:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1742r8vkwMjzem5FYEis21kVJKamrBt-TgDpMHHFsPw@mail.gmail.com>
Message-ID: <CAL_JsqJ1742r8vkwMjzem5FYEis21kVJKamrBt-TgDpMHHFsPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: Add ipsps1 as a trivial device
To:     John Wang <wangzqbj@inspur.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Patrick Venture <venture@google.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jeremy Gebben <jgebben@sweptlaser.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milton Miller <miltonm@us.ibm.com>,
        Lei YU <mine260309@gmail.com>, duanzhijia01@inspur.com,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 8:52 PM John Wang <wangzqbj@inspur.com> wrote:
>
> The ipsps1 is an Inspur Power System power supply unit
>
> Signed-off-by: John Wang <wangzqbj@inspur.com>
> ---
> v3:
>     - Fix adding entry to the inappropriate line
> v2:
>     - No changes.
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
