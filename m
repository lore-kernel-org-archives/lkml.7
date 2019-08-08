Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47707C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADAD217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbfHHOwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:52:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfHHOwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:52:34 -0400
Received: from [192.168.1.110] ([77.4.95.67]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MsZ3N-1iCApW1dLX-00u2bf; Thu, 08 Aug 2019 16:52:25 +0200
Subject: Re: Device to write to all (serial) consoles
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <7a3cecc9-fbf0-8ab4-f838-3e9ccb5f4e73@metux.net>
Date:   Thu, 8 Aug 2019 16:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <32c2d26f-ec4a-b9a6-b42c-07b27f99ea28@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u4fw68NsZw/9ZJe9K3gTNHy+SUHiXxxFu+DxCeWpZEgKg3nwmKn
 HLucGGv8glk/PcT4t1begl7v7hwvQfURB1IPLoGpRIKTaAWFY2ew5b6VoL8uBhAxiGXYj6U
 0pekj2cBNeNfJELCk3v4UrPGLLh9fC8iyQAPL+9sBUCylln/Bh1SiwbvdAMN4ClwUErZQG8
 P/3NVLTr3V4rWpwCsFCiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:txnzwr64LaQ=:H5TN2UGEyVk035HlawL2+6
 Ll9XUyrZiWmId9KBxY8h7OGSQEglfx0sB4XoQTe7OTai5PyfoOQq7jN8pB23eeqRSV1+y6VvF
 9CtN4ShcqygD1lvHhFh5+zBQssi6fESCBTGn3lyIhLxS3E53bv5+PCnKL2BEUhPnEPp5C4/ew
 vg0WNcd/wCNTHGBQX/a2/FZzY+zfodvlqMGI88tYNApj86Xs22MOoeiLfwfP8iSLZjmP4PUEE
 Mvl+4C9rPTMK6REt5nIPW2ogPeYNJ/IKekjsCPLjw7hySF+XmfK6c/D6OgCNa0VpXFOrTj9O4
 XJTIAn3bM5VgfdJkV5sZz/bV/ruktIp3jYtTiM72SilFj56rOV4A9wrC4aW6lky7lLZrNxsc6
 hj6B9y7yf0K4mxn6c+tFHn4IH0bDX/LcMY4NIOEHZGtUEOp3e9LeeeGWj3EGyaqCBFabG2LPk
 cbAE0UuZdKKy2siNeQaRV13d7VNpKXenPXLZJem33qPaQUoPoylZ31LxMh69Am2yqjklIb34u
 2BzTlCdKUhyizJY69smDgBnrpFNQ52ukJtzTHqgjtCStm4NpcGXYWbkBCG/KsEQTs+Rpxqgdf
 yKWneDbSyrWn8+hckXg0FJqct7H3cw2RaJS6yX39wJTSCSh+f00Z9khRxxal7pIleIS4P8a+J
 xKsozRRgCXK4JBwGFq2KPwmekhLZGemDS7Uec83aMZ6T0TNrfOXm43j8Va+8SWBuBAqP8r7OQ
 SO78Sa2AYyYXzHihtFq0xHeRrAPwdCsrWN2NZTZhwjdhruJFRG+nBR8R5NI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.19 15:23, Paul Menzel wrote:

> Does a device exist, or can a device be configured so you can write to
> all (serial) consoles from user space?

Why not just writing a little program that listens on a pipe or a pty
and writes out everything to all the tty's you want ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
