Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A43C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B88720880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfDHI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:29:27 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44571 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDHI30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:29:26 -0400
Received: by mail-ed1-f53.google.com with SMTP id d11so10828761edp.11;
        Mon, 08 Apr 2019 01:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSyqGSNCVsRnOsy13fQGY+ha9TXep+PjqAR5peJVIiQ=;
        b=LhOpqrfH1g+EWBmo9dUFS+ocBQLD3vcFKMxKclX5nt/RvWMpHNJveJSsh0671ri6e2
         UfPP5/nlDMgvXMjPXbIiv3kImb8ODSWCVkwX8qCTL0J5mUyc9vJMhChmH8qpj7gqavBQ
         VWbVLIkgYOxmQ6AkLx/GbdOSdzi4mBCIXxz3GBJrMXCe+oRGPUblRfF9Cagz4IUfET3N
         AjyIV1N4+HjXDM8kN5zjQjQam77Vgh+sSqgey5J1E+tzOGxzXhOH8aG4Df3xYCgXlQLA
         qdnzZFN57Um+I/olUZtENFQ6afHrd4z/Wn9VL1f+hCily/BJRFum+UGZk4u9gIDjywJi
         kX6g==
X-Gm-Message-State: APjAAAUuKHcyjkSxot3iuftzVkvy9TYcYPLjeiF7qg874xpbuUmQ3ZHT
        ZOPmGgsdgivE67AUtFI78aehmyTXS9s=
X-Google-Smtp-Source: APXvYqwIzHpy+SR32V/5YkaOw/oBv9z3vLyDJyTUGKplJ4lTGa5TXCn3T446sXUaAW88+LAmJT+Mmw==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr11001769edq.141.1554712164623;
        Mon, 08 Apr 2019 01:29:24 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id r19sm1555540ejb.11.2019.04.08.01.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 01:29:23 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id j9so15230864wrn.6;
        Mon, 08 Apr 2019 01:29:23 -0700 (PDT)
X-Received: by 2002:a5d:4750:: with SMTP id o16mr14816287wrs.206.1554712163375;
 Mon, 08 Apr 2019 01:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190301185212.26837-1-andreas@kemnade.info>
In-Reply-To: <20190301185212.26837-1-andreas@kemnade.info>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 8 Apr 2019 16:29:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v674BhuwTs-m6cbKyXpU0Ae2uRhwDVaQyjs+zQRdWfPOtg@mail.gmail.com>
Message-ID: <CAGb2v674BhuwTs-m6cbKyXpU0Ae2uRhwDVaQyjs+zQRdWfPOtg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: sun8i: h3: bluetooth for Banana Pi M2 Zero board
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 2:53 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> The Banana Pi M2 Zero board has an AP6212 BT+Wifi combo chip
> with broadcom internals attached to UART1 and some gpios.

       ^ Broadcom

> This addition is in line with similar boards

This sentence is unfinished.

>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

ChenYu
