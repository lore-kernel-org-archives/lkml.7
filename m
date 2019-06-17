Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AE8C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7431D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfFQMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:14:38 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41648 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:14:38 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hcqWl-0004e6-Eg; Mon, 17 Jun 2019 14:14:23 +0200
Message-ID: <583907409fad854bd3c18be688ec2724ad7a60e9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/17] net: introduce Qualcomm IPA driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Elder <elder@linaro.org>, abhishek.esse@gmail.com,
        Ben Chan <benchan@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        cpratapa@codeaurora.org, David Miller <davem@davemloft.net>,
        Dan Williams <dcbw@redhat.com>,
        DTML <devicetree@vger.kernel.org>,
        Eric Caruso <ejcaruso@google.com>, evgreen@chromium.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-soc@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        syadagir@codeaurora.org
Date:   Mon, 17 Jun 2019 14:14:21 +0200
In-Reply-To: <CAK8P3a0kV-i7BJJ2X6C=5n65rSGfo8fUiC4J_G-+M8EctYKbkg@mail.gmail.com> (sfid-20190611_135708_651569_0097B773)
References: <380a6185-7ad1-6be0-060b-e6e5d4126917@linaro.org>
         <a94676381a5ca662c848f7a725562f721c43ce76.camel@sipsolutions.net>
         <CAK8P3a0kV-i7BJJ2X6C=5n65rSGfo8fUiC4J_G-+M8EctYKbkg@mail.gmail.com>
         (sfid-20190611_135708_651569_0097B773)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-11 at 13:56 +0200, Arnd Bergmann wrote:

[...]

Looking at the flags again,

> #define RMNET_FLAGS_INGRESS_DEAGGREGATION         (1U << 0)

This one I'm not sure I understand - seems weird to have such a
fundamental thing as a *configuration* on the channel.

> #define RMNET_FLAGS_INGRESS_MAP_COMMANDS          (1U << 1)

Similar here? If you have flow control you probably want to use it?

> #define RMNET_FLAGS_INGRESS_MAP_CKSUMV4           (1U << 2)

This again looks like a hardware specific feature (ipv4 checksum)? Not
sure why this is set by userspace.

> #define RMNET_FLAGS_EGRESS_MAP_CKSUMV4            (1U << 3)

This could be set with ethtool instead, I suppose.

johannes

