Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E9C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B55120848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfCYVYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:24:39 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:41400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729569AbfCYVYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:24:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2104F182CF668;
        Mon, 25 Mar 2019 21:24:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cave03_b38e118dc05e
X-Filterd-Recvd-Size: 2566
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:24:36 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Bad file pattern in MAINTAINERS section 'ANALOG DEVICES INC AD7606 DRIVER'
Date:   Mon, 25 Mar 2019 14:24:35 -0700
Message-Id: <20190325212435.25587-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	865	ANALOG DEVICES INC AD7606 DRIVER
	866	M:	Stefan Popa <stefan.popa@analog.com>
	867	L:	linux-iio@vger.kernel.org
	868	W:	http://ez.analog.com/community/linux-device-drivers
	869	S:	Supported
	870	F:	drivers/iio/adc/ad7606.c
-->	871	F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'Documentation/devicetree/bindings/iio/adc/ad7606.txt':

commit 6e33a125df66664a09cd518a2e1dd63b4ccddef8
Author: Stefan Popa <stefan.popa@analog.com>
Date:   Mon Dec 17 14:23:40 2018 +0200

    dt-bindings: iio: adc: Add docs for AD7606 ADC
    
    Document support for AD7606 Analog to Digital Converter.
    
    Signed-off-by: Stefan Popa <stefan.popa@analog.com>
    Reviewed-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 65 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 66 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'Documentation/devicetree/bindings/iio/adc/ad7606.txt' was found
