Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23688C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEED920828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfH0JV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:21:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0JV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:21:26 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id B83BB7482842402892CA;
        Tue, 27 Aug 2019 17:21:23 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 27 Aug 2019 17:21:21 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 27 Aug 2019 17:21:20 +0800
Date:   Tue, 27 Aug 2019 17:20:36 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        <devel@driverdev.osuosl.org>, <elder@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, <johan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <greybus-dev@lists.linaro.org>,
        <yuchao0@huawei.com>
Subject: Re: [PATCH 1/9] staging: greybus: fix up SPDX comment in .h files
Message-ID: <20190827092036.GA138083@architecture4>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190825055429.18547-2-gregkh@linuxfoundation.org>
 <20190826055119.4pbmf5ape224giwz@vireshk-i7>
 <20190827075802.GA29204@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827075802.GA29204@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Aug 27, 2019 at 09:58:02AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 26, 2019 at 11:21:19AM +0530, Viresh Kumar wrote:
> > On 25-08-19, 07:54, Greg Kroah-Hartman wrote:
> > > When these files originally got an SPDX tag, I used // instead of /* */
> > > for the .h files.  Fix this up to use // properly.
> > > 
> > > Cc: Viresh Kumar <vireshk@kernel.org>
> > > Cc: Johan Hovold <johan@kernel.org>
> > > Cc: Alex Elder <elder@kernel.org>
> > > Cc: greybus-dev@lists.linaro.org
> > > Cc: devel@driverdev.osuosl.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/staging/greybus/firmware.h               | 2 +-
> > >  drivers/staging/greybus/gb-camera.h              | 2 +-
> > >  drivers/staging/greybus/gbphy.h                  | 2 +-
> > >  drivers/staging/greybus/greybus.h                | 2 +-
> > >  drivers/staging/greybus/greybus_authentication.h | 2 +-
> > >  drivers/staging/greybus/greybus_firmware.h       | 2 +-
> > >  drivers/staging/greybus/greybus_manifest.h       | 2 +-
> > >  drivers/staging/greybus/greybus_protocols.h      | 2 +-
> > >  drivers/staging/greybus/greybus_trace.h          | 2 +-
> > >  drivers/staging/greybus/hd.h                     | 2 +-
> > >  drivers/staging/greybus/interface.h              | 2 +-
> > >  drivers/staging/greybus/manifest.h               | 2 +-
> > >  drivers/staging/greybus/module.h                 | 2 +-
> > >  drivers/staging/greybus/operation.h              | 2 +-
> > >  drivers/staging/greybus/spilib.h                 | 2 +-
> > >  drivers/staging/greybus/svc.h                    | 2 +-
> > >  16 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks for all of the acks!
> 
> greg k-h

I found similar issues of graybus when I tested the latest staging-testing

In file included from <command-line>:0:0:
./include/linux/greybus/greybus_protocols.h:45:2: error: unknown type name ¡®__le16¡¯
  __le16 size;  /* Size in bytes of header + payload */
  ^~~~~~
./include/linux/greybus/greybus_protocols.h:46:2: error: unknown type name ¡®__le16¡¯
  __le16 operation_id; /* Operation unique id */
  ^~~~~~
./include/linux/greybus/greybus_protocols.h:47:2: error: unknown type name ¡®__u8¡¯
  __u8 type;  /* E.g GB_I2C_TYPE_* or GB_GPIO_TYPE_* */
  ^~~~
./include/linux/greybus/greybus_protocols.h:48:2: error: unknown type name ¡®__u8¡¯
  __u8 result;  /* Result of request (in responses only) */
  ^~~~
./include/linux/greybus/greybus_protocols.h:49:2: error: unknown type name ¡®__u8¡¯
  __u8 pad[2];  /* must be zero (ignore when read) */
  ^~~~
./include/linux/greybus/greybus_protocols.h:58:2: error: unknown type name ¡®__u8¡¯
  __u8 phase;
  ^~~~
./include/linux/greybus/greybus_protocols.h:88:2: error: unknown type name ¡®__u8¡¯
  __u8 major;
  ^~~~
./include/linux/greybus/greybus_protocols.h:89:2: error: unknown type name ¡®__u8¡¯
  __u8 minor;
  ^~~~
./include/linux/greybus/greybus_protocols.h:93:2: error: unknown type name ¡®__u8¡¯
  __u8 major;
  ^~~~
./include/linux/greybus/greybus_protocols.h:94:2: error: unknown type name ¡®__u8¡¯
  __u8 minor;
  ^~~~
./include/linux/greybus/greybus_protocols.h:98:2: error: unknown type name ¡®__u8¡¯
  __u8 bundle_id;
  ^~~~
./include/linux/greybus/greybus_protocols.h:102:2: error: unknown type name ¡®__u8¡¯
  __u8 major;
  ^~~~
./include/linux/greybus/greybus_protocols.h:103:2: error: unknown type name ¡®__u8¡¯
  __u8 minor;
  ^~~~
./include/linux/greybus/greybus_protocols.h:108:2: error: unknown type name ¡®__le16¡¯
  __le16   size;
  ^~~~~~
./include/linux/greybus/greybus_protocols.h:113:2: error: unknown type name ¡®__u8¡¯
  __u8   data[0];
  ^~~~
./include/linux/greybus/greybus_protocols.h:118:2: error: unknown type name ¡®__le16¡¯
  __le16   cport_id;
  ^~~~~~
./include/linux/greybus/greybus_protocols.h:122:2: error: unknown type name ¡®__le16¡¯
  __le16   cport_id;

.. and other files...

Not very sure... but it seems it can be observed with allmodconfig or
CONFIG_KERNEL_HEADER_TEST=y and fail my compilation...
Hope that of some help (kind reminder...)

Thanks,
Gao Xiang


> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
