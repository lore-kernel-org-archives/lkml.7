Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60BC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8431208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfFJVDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:03:36 -0400
Received: from smtp3.emailarray.com ([65.39.216.17]:39971 "EHLO
        smtp3.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbfFJVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:03:35 -0400
Received: (qmail 34735 invoked by uid 89); 10 Jun 2019 20:56:55 -0000
Received: from unknown (HELO ?172.20.174.171?) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTk5LjIwMS42NC4y) (POLARISLOCAL)  
  by smtp3.emailarray.com with (AES256-GCM-SHA384 encrypted) SMTP; 10 Jun 2019 20:56:55 -0000
From:   "Jonathan Lemon" <jlemon@flugsvamp.com>
To:     "Ilya Maximets" <i.maximets@samsung.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@intel.com>,
        "Magnus Karlsson" <magnus.karlsson@intel.com>
Subject: Re: [PATCH bpf] xdp: check device pointer before clearing
Date:   Mon, 10 Jun 2019 13:56:49 -0700
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <76A4186A-5495-4003-A494-7DE0B15EFB1A@flugsvamp.com>
In-Reply-To: <20190607172732.4710-1-i.maximets@samsung.com>
References: <CGME20190607172737eucas1p28508d5e198907695bc77f9fd18ce233e@eucas1p2.samsung.com>
 <20190607172732.4710-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jun 2019, at 10:27, Ilya Maximets wrote:

> We should not call 'ndo_bpf()' or 'dev_put()' with NULL argument.
>
> Fixes: c9b47cc1fabc ("xsk: fix bug when trying to use both copy and 
> zero-copy on one queue id")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
