Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C592187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfGCN1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:27:19 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:27:18 -0400
Received: from [192.168.1.110] ([95.114.150.241]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBlpC-1ho7Kg0j64-00C8ca; Wed, 03 Jul 2019 15:27:14 +0200
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
To:     jeyentam <je.yen.tam@ni.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190703072435.34152-1-je.yen.tam@ni.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
Date:   Wed, 3 Jul 2019 15:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190703072435.34152-1-je.yen.tam@ni.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:88OtvEu5RKkHMkcjy/zKAH4e4olL3QESNrsVOKCIoavVk+OQ4lL
 KpwDF61skuRLCrX/plfmludB9ZchcZFssARMhG3gz3VLZEo2oqqxx4GLN/TEa0GWzHCwAfB
 NvHuzdGj0Q/P+5CSrKUIVYvJo3vfpckh4m4O9qePhyBq4aXAsgSlMDwAGwJkViO22AOMxmV
 2R8QVA0PhgpA6y9ZBEepQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wz/rYjhdZS8=:+qQ6pl+Su62RMg4KobnxdG
 l7WrNMOIKWd+MP7OS4uoyWjMGtm7la73PmEdwywXhkzJPzKv8g6kUfQQgH7IfdXa3GFtLUBWu
 rGxuPvZpBIjoGLic7Xh1CeJZQjP2peXX/iMdcRXGLavCXfn/fih8TFLtQP0WjH9+Q0aBtyE76
 ETSxdMwmPGcmdRLcfGUZU842opcYwIdWLXqOcpnZfsgg+VeuvHGvLolGwkA9QAmD5/qR0ouQ6
 92TBoqEr/x7jG+4XTl2+p1rz96/WLc03co17J0bmnRxe6sT/kffY8kSeL7cQzwCR4xYZwYa5Y
 AFMD+LrBmeUUQJCJIZnLGOvYdhx2IErKEpRPjyX4Hxqhlcb+KgP0uwwCeL9YjUkza1ujztM4r
 qTnHLV6JUfNLv1VnUf5bpbCYTeINMOtasU9uPVCEUVuDBw8UyWb8qCBKxczADNfXHvGq9XH/m
 /q0KlbJ4FEPhDwhqrhAxE1OnywTI6BOK3yQfbqS4CKK3jyJP25Qm8UmbHBzY1ibXnoSEqbOUU
 m1Nk73rOZzBCz3TJBN4FhhhSrK0ZwEKNBR7UsHytJyZE+3YHxiW2J5cIL8GnGAPs3MKF2zw7U
 RB0/UhSZIEf58K4eOqVtnog6mMeBXbQeFmTFL16mXtInmGQo/j/7EWvFj204BUGoz6RtA28+U
 ZsxZu3rNuIBzprggMZWz/Qy8KHZ86omOdPFBm1hC5FD3WwSrlMwOSLa6pBjqNOv9oI31ixr6X
 2OavRLiynVWHeoiltf58xnH035jcsiT9QgQgY9/YqHoVIdAig4wYdgMaOQs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.19 09:24, jeyentam wrote:

Hi,

besides what Greg already said:

>  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
Can we have that renaming as a separate patch, to ease review ?

And what about introducing a config sym for the new device specific
stuff ? These devices seem to be pretty rare - never seen them in
embeded world, where we do need to care of kernel size.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
