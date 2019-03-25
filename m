Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82218C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D86520848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfCYVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:24:55 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:36846 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729569AbfCYVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:24:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8477A180A8867;
        Mon, 25 Mar 2019 21:24:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: note99_d528fa80be60
X-Filterd-Recvd-Size: 3741
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:24:51 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Bad file pattern in MAINTAINERS section 'ARM/QUALCOMM SUPPORT'
Date:   Mon, 25 Mar 2019 14:24:50 -0700
Message-Id: <20190325212450.25865-1-joe@perches.com>
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

	1986	ARM/QUALCOMM SUPPORT
	1987	M:	Andy Gross <andy.gross@linaro.org>
	1988	M:	David Brown <david.brown@linaro.org>
	1989	L:	linux-arm-msm@vger.kernel.org
	1990	S:	Maintained
	1991	F:	Documentation/devicetree/bindings/soc/qcom/
	1992	F:	Documentation/devicetree/bindings/*/qcom*
	1993	F:	arch/arm/boot/dts/qcom-*.dts
	1994	F:	arch/arm/boot/dts/qcom-*.dtsi
	1995	F:	arch/arm/mach-qcom/
	1996	F:	arch/arm64/boot/dts/qcom/
	1997	F:	drivers/*/qcom/
	1998	F:	drivers/*/qcom*
	1999	F:	drivers/*/*/qcom/
	2000	F:	drivers/*/*/qcom*
	2001	F:	drivers/*/pm8???-*
	2002	F:	drivers/bluetooth/btqcomsmd.c
	2003	F:	drivers/clocksource/timer-qcom.c
	2004	F:	drivers/extcon/extcon-qcom*
	2005	F:	drivers/iommu/msm*
	2006	F:	drivers/i2c/busses/i2c-qup.c
	2007	F:	drivers/i2c/busses/i2c-qcom-geni.c
	2008	F:	drivers/mfd/ssbi.c
	2009	F:	drivers/mmc/host/mmci_qcom*
-->	2010	F:	drivers/mmc/host/sdhci_msm.c
	2011	F:	drivers/pci/controller/dwc/pcie-qcom.c
	2012	F:	drivers/phy/qualcomm/
	2013	F:	drivers/power/*/msm*
	2014	F:	drivers/reset/reset-qcom-*
	2015	F:	drivers/scsi/ufs/ufs-qcom.*
	2016	F:	drivers/spi/spi-qup.c
	2017	F:	drivers/spi/spi-geni-qcom.c
	2018	F:	drivers/spi/spi-qcom-qspi.c
	2019	F:	drivers/tty/serial/msm_serial.c
	2020	F:	drivers/usb/dwc3/dwc3-qcom.c
	2021	F:	include/dt-bindings/*/qcom*
	2022	F:	include/linux/*/qcom*
	2023	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/mmc/host/sdhci_msm.c':

commit e31f941cf977f4ed7882358de2f513cac5865330
Author: Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue Jan 15 01:15:49 2019 +0530

    MAINTAINERS: update list of qcom drivers
    
    Several drivers didn't have a specific maintainer (other than the
    subsystem maintainer). Add some generic regex patterns to capture most
    qcom drivers in the list of supported drivers. For the rest, add
    explicit filenames.
    
    Sort the entries, while we're at it.
    
    Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
    Signed-off-by: Andy Gross <andy.gross@linaro.org>

 MAINTAINERS | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/mmc/host/sdhci_msm.c' was found
