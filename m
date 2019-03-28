Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0583C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8A920823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfC1Tjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:39:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51431 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfC1Tjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:39:52 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.43])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2SJdH8J3459445
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 28 Mar 2019 12:39:18 -0700
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
To:     Randy Dunlap <rdunlap@infradead.org>, cminyard@mvista.com
Cc:     minyard@acm.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190305171231.22133-1-minyard@acm.org>
 <eea0ad95-8344-371a-1dd0-58c8366a355b@infradead.org>
 <20190306015149.GD4290@minyard.net>
 <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <447407be-0f49-f29d-6e81-bf4ed0a6e56b@zytor.com>
Date:   Thu, 28 Mar 2019 12:39:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <041e137e-0b9d-04f9-255d-b1f402b23c17@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dumb question: this is basically a pty on steroids. Wouldn't this be
better done by enhancing the pty devices?

	-0hpa

