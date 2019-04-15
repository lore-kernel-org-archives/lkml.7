Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1610C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE32084B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Coe5Enii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfDOXIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:08:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDOXIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:08:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FMxTTU003733;
        Mon, 15 Apr 2019 23:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=gVOwkUNztHByfAmrzo/gvxequkxH+bdWHbVmUxwfpaI=;
 b=Coe5EniiXipW5An2Wn9dKmZGJMPF0kGob0pHSe5XmAZuHhl8237LZu4y11s7NYawgfml
 MpvWwYsXcCmL6mEiW7w6oJSE6IHYIYWEN2Zk8UtgxSdAwsfQR7gNJTFaXb/XTdvioFHq
 U2s8l5vF9Y0o88Ggh/f74sIhVmfyC2jAXPlB7wHtYLT+6EebOa3VFsU11JnIMdeRunj3
 utEy8M7eyaRVNXFlv6ipxbVgpAx2g+L5ne0pZGaOUQeFTsMnAFn+urZfuUtzdAWgL0NN
 mCd6YqDOyvkEnRJ+JKd3UQr3ESREFPo3bKvETlZw4X9yZHlOtx+Rtxb7mr3swUeNIn0a Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rusneqf1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 23:08:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FN8Mwb008510;
        Mon, 15 Apr 2019 23:08:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rubq60nxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 23:08:39 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3FN8clj018292;
        Mon, 15 Apr 2019 23:08:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 16:08:38 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/9] hisi_sas: Some misc patches
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1554986804-233706-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 15 Apr 2019 19:08:34 -0400
In-Reply-To: <1554986804-233706-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 11 Apr 2019 20:46:35 +0800")
Message-ID: <yq1zhoqhnnx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=864
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150154
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=904 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> The patchset introduces improvements, more minor fixes, and new features
> for the driver, including:
> - Host reset interface
> - Switch all HW error handling to MSI
> - Give SATA disk unique (fake) SAS address for v3 hw
> - Some error handling fixes
> - Some tidy-up

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
