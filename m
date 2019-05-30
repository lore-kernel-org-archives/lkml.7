Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB05C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CBE243D7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="153vMePa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfE3Bg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:36:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:36:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1YMoD160919;
        Thu, 30 May 2019 01:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=7e2gvQJw68TcHhBtlQevW3z0rO3vwTqu6igHTvHuJ38=;
 b=153vMePaItf7lQ+JryaGrtQVtrGbkt4VIwWVOfLOlqrExI0KeLtBcOep6ZV0mv1KKWkc
 QPmAa1kT2FM3tjoxcJQEcb0aEQhTiJDxWmIa5MdVzr35y7e1wJ/+z3YBW4AatjCKFr44
 TzlXptl8WnfRPwydWpefjvmntkVhbiDq6YpqFdATBqnfSqtcKAYrY4wNobFWWCabNa9W
 4Oy1g7lk7q40/kwNaWrOiaFiMeqS7mbi/kX05duYhmxVLZHEG4/tvflim15RF2mjfJLI
 cm37SxsB9DQ+aBixwaLUSkdP7hVmmTAm32cz6anOsZWRW00Wl0/ejD907g1SuEBL5H+N sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2spw4tn914-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:36:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1YNvY146914;
        Thu, 30 May 2019 01:36:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh741m03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:36:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U1a92w005119;
        Thu, 30 May 2019 01:36:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:36:09 -0700
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     jinpu.wang@profitbricks.com, lindar_liu@usish.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fix typos in code comments
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190520032403.12513-1-houweitaoo@gmail.com>
Date:   Wed, 29 May 2019 21:36:07 -0400
In-Reply-To: <20190520032403.12513-1-houweitaoo@gmail.com> (Weitao Hou's
        message of "Mon, 20 May 2019 11:24:03 +0800")
Message-ID: <yq1y32ozptk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=670
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=709 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Weitao,

> fix abord to abort

Updated patch header to reflect the pm8001 driver and applied to
5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
