Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA95C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50688206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCDOCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:02:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:50282 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfCDOCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:02:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 06:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="304239758"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2019 06:02:20 -0800
Subject: Re: Linux Kernel - problem
To:     Cezary Lenkiewicz <missionfanboy@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CANVrK2R+Lfb2_-jwZrfHPyoJU936Exf7+O+uUUnCJQb=fVhnRQ@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <185b7bc6-900a-1cde-106f-96ead6dcc6ba@intel.com>
Date:   Mon, 4 Mar 2019 16:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CANVrK2R+Lfb2_-jwZrfHPyoJU936Exf7+O+uUUnCJQb=fVhnRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.3.2019 14.17, Cezary Lenkiewicz wrote:
> Hello,
> I have problem with Euphony system - this is linux for audio.
> I talking with Euphony support but they say that the problem is in the linux kernel.
> 
> Please show my conversation with euphony:
> 
> https://euphony-audio.com/hesk/ticket.php?track=T4N-M6G-XHAE&e=missionfanboy%40gmail.com&Refresh=49662
> 
> Can you fix this PLEASE ?

Feb 28 17:11:34 euphony kernel: xhci_hcd 0000:04:00.0: ERROR: unexpected command completion code 0x11.
Feb 28 17:11:34 euphony kernel: usb 5-1.1: Not enough bandwidth for altsetting 1

Completion code 0x11 (17) is parameter error, this means some value in
a context parameter is invalid.

Many of these context parameter are taken from the descriptors of the
attached usb device  (device, interface, endpoint descriptors)

More details are needed, output of "lsusb -v", and dynamic debug of
xhci and usbcore would be a good start

-Mathias


