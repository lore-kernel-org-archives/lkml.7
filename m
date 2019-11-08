Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E99C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528F4214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfKHJgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:36:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730573AbfKHJgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:36:05 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89WE3u091186
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 04:36:04 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w541c3vur-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:36:03 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Fri, 8 Nov 2019 09:36:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 09:35:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA89ZvSc66453662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 09:35:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47BA711C05C;
        Fri,  8 Nov 2019 09:35:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79C111C05B;
        Fri,  8 Nov 2019 09:35:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 09:35:56 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.221.11])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5A0B0A01E3;
        Fri,  8 Nov 2019 20:35:54 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 02/11] fsi: Move master attributes to fsi-master class
Date:   Fri, 08 Nov 2019 20:18:57 +1100
In-Reply-To: <20191108051945.7109-3-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au> <20191108051945.7109-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19110809-4275-0000-0000-0000037BEAE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110809-4276-0000-0000-0000388F3ECB
Message-Id: <1875965.3q8Q5IJkUj@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Alistair Popple <alistair@popple.id.au>

On Friday, 8 November 2019 4:19:36 PM AEDT Joel Stanley wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> 
> Populate fsi_master_class->dev_attrs with the existing attribute
> definitions, so we don't need to explicitly register.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-core.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 0861f6097b33..c773c65a5058 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1241,8 +1241,17 @@ static ssize_t master_break_store(struct device *dev,
>  
>  static DEVICE_ATTR(break, 0200, NULL, master_break_store);
>  
> +static struct attribute *master_attrs[] = {
> +	&dev_attr_break.attr,
> +	&dev_attr_rescan.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(master);
> +
>  struct class fsi_master_class = {
>  	.name = "fsi-master",
> +	.dev_groups = master_groups,
>  };
>  
>  int fsi_master_register(struct fsi_master *master)
> @@ -1261,20 +1270,6 @@ int fsi_master_register(struct fsi_master *master)
>  		return rc;
>  	}
>  
> -	rc = device_create_file(&master->dev, &dev_attr_rescan);
> -	if (rc) {
> -		device_del(&master->dev);
> -		ida_simple_remove(&master_ida, master->idx);
> -		return rc;
> -	}
> -
> -	rc = device_create_file(&master->dev, &dev_attr_break);
> -	if (rc) {
> -		device_del(&master->dev);
> -		ida_simple_remove(&master_ida, master->idx);
> -		return rc;
> -	}
> -
>  	np = dev_of_node(&master->dev);
>  	if (!of_property_read_bool(np, "no-scan-on-init")) {
>  		mutex_lock(&master->scan_lock);
> 




